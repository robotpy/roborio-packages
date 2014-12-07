#ifndef ATLAS_MVN_H
#define ATLAS_MVN_H

#include "atlas_misc.h"

#define ATL_mvNMU 4
#define ATL_mvNNU 4
#ifndef ATL_L1mvelts
   #define ATL_L1mvelts ((3*ATL_L1elts)>>2)
#endif
#ifndef ATL_mvpagesize
   #define ATL_mvpagesize ATL_DivBySize(4096)
#endif
#ifndef ATL_mvntlb
   #define ATL_mvntlb 56
#endif

#define ATL_GetPartMVN(A_, lda_, mb_, nb_) \
{ \
   *(nb_) = (ATL_L1mvelts - (ATL_mvNMU<<1)) / ((ATL_mvNMU<<1)+1); \
   if (ATL_mvpagesize > (lda_)) \
   { \
      *(mb_) = (ATL_mvpagesize / (lda_)) * ATL_mvntlb; \
      if ( *(mb_) < *(nb_) ) *(nb_) = *(mb_); \
   } \
   else if (ATL_mvntlb < *(nb_)) *(nb_) = ATL_mvntlb; \
   if (*(nb_) > ATL_mvNNU) *(nb_) = (*(nb_) / ATL_mvNNU) * ATL_mvNNU; \
   else *(nb_) = ATL_mvNNU; \
   *(mb_) = (ATL_L1mvelts - *(nb_) * (ATL_mvNMU+1)) / (*(nb_)+2); \
   if (*(mb_) > ATL_mvNMU) *(mb_) = (*(mb_) / ATL_mvNMU) * ATL_mvNMU; \
   else *(mb_) = ATL_mvNMU; \
}

#endif
