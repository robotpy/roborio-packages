#ifndef ATL_ztGetNB_geqrf

/*
 * NB selection for GEQRF: Side='RIGHT', Uplo='UPPER'
 * M : 25,216,288,432,864
 * N : 25,216,288,432,864
 * NB : 2,20,20,32,36
 */
#define ATL_ztGetNB_geqrf(n_, nb_) \
{ \
   if ((n_) < 120) (nb_) = 2; \
   else if ((n_) < 360) (nb_) = 20; \
   else if ((n_) < 648) (nb_) = 32; \
   else (nb_) = 36; \
}


#endif    /* end ifndef ATL_ztGetNB_geqrf */
