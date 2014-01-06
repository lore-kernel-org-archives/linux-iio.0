Return-Path: <lars@metafoo.de>
Message-ID: <52CAF0CB.7090404@metafoo.de>
Date: Mon, 06 Jan 2014 19:07:07 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: kbuild test robot <fengguang.wu@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, kbuild-all@01.org,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [iio:togreg 15/46] drivers/iio/kfifo_buf.c:160:2: error: unknown
 field 'data_available' specified in initializer
References: <52caeebf.H+6mzRdjL24A0dvf%fengguang.wu@intel.com>
In-Reply-To: <52caeebf.H+6mzRdjL24A0dvf%fengguang.wu@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

I think the faulty commit is this one c9190956 ("
staging:iio:dummy fix kfifo_buf kconfig dependency issue if kfifo modular
and buffer enabled for built in dummy driver"). It selects IIO_KFIFO_BUF
without also selecting IIO_BUFFER or depending on IIO_BUFFER.

- Lars

On 01/06/2014 06:58 PM, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> head:   6fd92d3add999fbcc7178a07cbc6360f66a306ba
> commit: 355c1a14d4009a43e4d1f9cb42a382f0a94d01c4 [15/46] iio: kfifo_buf: Implement data_available() callback
> config: i386-randconfig-j2-01062117 (attached as .config)
> 
> All error/warnings:
> 
>      return r->bytes_per_datum;
>      ^
>    drivers/iio/kfifo_buf.c: In function 'iio_mark_update_needed_kfifo':
>    drivers/iio/kfifo_buf.c:76:86: warning: initialization from incompatible pointer type [enabled by default]
>      struct iio_kfifo *kf = iio_to_kfifo(r);
>                                                                                          ^
>    drivers/iio/kfifo_buf.c:76:86: warning: (near initialization for 'kf') [enabled by default]
>    drivers/iio/kfifo_buf.c:76:128: error: invalid operands to binary - (have 'char *' and 'struct attribute **')
>      struct iio_kfifo *kf = iio_to_kfifo(r);
>                                                                                                                                    ^
>    drivers/iio/kfifo_buf.c: In function 'iio_set_bytes_per_datum_kfifo':
>    drivers/iio/kfifo_buf.c:83:7: error: dereferencing pointer to incomplete type
>      if (r->bytes_per_datum != bpd) {
>           ^
>    drivers/iio/kfifo_buf.c:83:7: error: request for member 'bytes_per_datum' in something not a structure or union
>    drivers/iio/kfifo_buf.c:83:25: warning: comparison between pointer and integer [enabled by default]
>      if (r->bytes_per_datum != bpd) {
>                             ^
>    drivers/iio/kfifo_buf.c:84:4: error: dereferencing pointer to incomplete type
>       r->bytes_per_datum = bpd;
>        ^
>    drivers/iio/kfifo_buf.c:84:4: error: request for member 'bytes_per_datum' in something not a structure or union
>    drivers/iio/kfifo_buf.c:84:3: warning: statement with no effect [-Wunused-value]
>       r->bytes_per_datum = bpd;
>       ^
>    drivers/iio/kfifo_buf.c: In function 'iio_set_length_kfifo':
>    drivers/iio/kfifo_buf.c:95:7: error: dereferencing pointer to incomplete type
>      if (r->length != length) {
>           ^
>    drivers/iio/kfifo_buf.c:95:7: error: request for member 'length' in something not a structure or union
>    drivers/iio/kfifo_buf.c:95:16: warning: comparison between pointer and integer [enabled by default]
>      if (r->length != length) {
>                    ^
>    drivers/iio/kfifo_buf.c:96:4: error: dereferencing pointer to incomplete type
>       r->length = length;
>        ^
>    drivers/iio/kfifo_buf.c:96:4: error: request for member 'length' in something not a structure or union
>    drivers/iio/kfifo_buf.c:96:3: warning: statement with no effect [-Wunused-value]
>       r->length = length;
>       ^
>    drivers/iio/kfifo_buf.c: In function 'iio_store_to_kfifo':
>    drivers/iio/kfifo_buf.c:106:86: warning: initialization from incompatible pointer type [enabled by default]
>      struct iio_kfifo *kf = iio_to_kfifo(r);
>                                                                                          ^
>    drivers/iio/kfifo_buf.c:106:86: warning: (near initialization for 'kf') [enabled by default]
>    drivers/iio/kfifo_buf.c:106:128: error: invalid operands to binary - (have 'char *' and 'struct attribute **')
>      struct iio_kfifo *kf = iio_to_kfifo(r);
>                                                                                                                                    ^
>    drivers/iio/kfifo_buf.c:111:14: error: dereferencing pointer to incomplete type
>      wake_up_interruptible_poll(&r->pollq, POLLIN | POLLRDNORM);
>                  ^
>    drivers/iio/kfifo_buf.c:111:14: error: request for member 'pollq' in something not a structure or union
>    drivers/iio/kfifo_buf.c:111:2: warning: passing argument 1 of '__wake_up' from incompatible pointer type [enabled by default]
>      wake_up_interruptible_poll(&r->pollq, POLLIN | POLLRDNORM);
>      ^
>    In file included from include/linux/mmzone.h:9:0,
>                     from include/linux/gfp.h:4,
>                     from include/linux/slab.h:14,
>                     from drivers/iio/kfifo_buf.c:1:
>    include/linux/wait.h:144:6: note: expected 'struct wait_queue_head_t *' but argument is of type 'struct attribute * (*)[1]'
>     void __wake_up(wait_queue_head_t *q, unsigned int mode, int nr, void *key);
>          ^
>    drivers/iio/kfifo_buf.c: In function 'iio_read_first_n_kfifo':
>    drivers/iio/kfifo_buf.c:120:86: warning: initialization from incompatible pointer type [enabled by default]
>      struct iio_kfifo *kf = iio_to_kfifo(r);
>                                                                                          ^
>    drivers/iio/kfifo_buf.c:120:86: warning: (near initialization for 'kf') [enabled by default]
>    drivers/iio/kfifo_buf.c:120:128: error: invalid operands to binary - (have 'char *' and 'struct attribute **')
>      struct iio_kfifo *kf = iio_to_kfifo(r);
>                                                                                                                                    ^
>    drivers/iio/kfifo_buf.c: In function 'iio_kfifo_buf_data_available':
>    drivers/iio/kfifo_buf.c:138:86: warning: initialization from incompatible pointer type [enabled by default]
>      struct iio_kfifo *kf = iio_to_kfifo(r);
>                                                                                          ^
>    drivers/iio/kfifo_buf.c:138:86: warning: (near initialization for 'kf') [enabled by default]
>    drivers/iio/kfifo_buf.c:138:128: error: invalid operands to binary - (have 'char *' and 'struct attribute **')
>      struct iio_kfifo *kf = iio_to_kfifo(r);
>                                                                                                                                    ^
>    drivers/iio/kfifo_buf.c: In function 'iio_kfifo_buffer_release':
>    drivers/iio/kfifo_buf.c:150:86: warning: initialization from incompatible pointer type [enabled by default]
>      struct iio_kfifo *kf = iio_to_kfifo(buffer);
>                                                                                          ^
>    drivers/iio/kfifo_buf.c:150:86: warning: (near initialization for 'kf') [enabled by default]
>    drivers/iio/kfifo_buf.c:150:133: error: invalid operands to binary - (have 'char *' and 'struct attribute **')
>      struct iio_kfifo *kf = iio_to_kfifo(buffer);
>                                                                                                                                         ^
>    drivers/iio/kfifo_buf.c: At top level:
>    drivers/iio/kfifo_buf.c:157:21: error: variable 'kfifo_access_funcs' has initializer but incomplete type
>     static const struct iio_buffer_access_funcs kfifo_access_funcs = {
>                         ^
>    drivers/iio/kfifo_buf.c:158:2: error: unknown field 'store_to' specified in initializer
>      .store_to = &iio_store_to_kfifo,
>      ^
>    drivers/iio/kfifo_buf.c:158:2: warning: excess elements in struct initializer [enabled by default]
>    drivers/iio/kfifo_buf.c:158:2: warning: (near initialization for 'kfifo_access_funcs') [enabled by default]
>    drivers/iio/kfifo_buf.c:159:2: error: unknown field 'read_first_n' specified in initializer
>      .read_first_n = &iio_read_first_n_kfifo,
>      ^
>    drivers/iio/kfifo_buf.c:159:2: warning: excess elements in struct initializer [enabled by default]
>    drivers/iio/kfifo_buf.c:159:2: warning: (near initialization for 'kfifo_access_funcs') [enabled by default]
>>> drivers/iio/kfifo_buf.c:160:2: error: unknown field 'data_available' specified in initializer
>      .data_available = iio_kfifo_buf_data_available,
>      ^
>    drivers/iio/kfifo_buf.c:160:2: warning: excess elements in struct initializer [enabled by default]
>    drivers/iio/kfifo_buf.c:160:2: warning: (near initialization for 'kfifo_access_funcs') [enabled by default]
>    drivers/iio/kfifo_buf.c:161:2: error: unknown field 'request_update' specified in initializer
>      .request_update = &iio_request_update_kfifo,
>      ^
>    drivers/iio/kfifo_buf.c:161:2: warning: excess elements in struct initializer [enabled by default]
>    drivers/iio/kfifo_buf.c:161:2: warning: (near initialization for 'kfifo_access_funcs') [enabled by default]
>    drivers/iio/kfifo_buf.c:162:2: error: unknown field 'get_bytes_per_datum' specified in initializer
>      .get_bytes_per_datum = &iio_get_bytes_per_datum_kfifo,
>      ^
>    drivers/iio/kfifo_buf.c:162:2: warning: excess elements in struct initializer [enabled by default]
>    drivers/iio/kfifo_buf.c:162:2: warning: (near initialization for 'kfifo_access_funcs') [enabled by default]
>    drivers/iio/kfifo_buf.c:163:2: error: unknown field 'set_bytes_per_datum' specified in initializer
>      .set_bytes_per_datum = &iio_set_bytes_per_datum_kfifo,
>      ^
>    drivers/iio/kfifo_buf.c:163:2: warning: excess elements in struct initializer [enabled by default]
>    drivers/iio/kfifo_buf.c:163:2: warning: (near initialization for 'kfifo_access_funcs') [enabled by default]
>    drivers/iio/kfifo_buf.c:164:2: error: unknown field 'get_length' specified in initializer
>      .get_length = &iio_get_length_kfifo,
>      ^
>    drivers/iio/kfifo_buf.c:164:2: warning: excess elements in struct initializer [enabled by default]
>    drivers/iio/kfifo_buf.c:164:2: warning: (near initialization for 'kfifo_access_funcs') [enabled by default]
>    drivers/iio/kfifo_buf.c:165:2: error: unknown field 'set_length' specified in initializer
>      .set_length = &iio_set_length_kfifo,
>      ^
>    drivers/iio/kfifo_buf.c:165:2: warning: excess elements in struct initializer [enabled by default]
>    drivers/iio/kfifo_buf.c:165:2: warning: (near initialization for 'kfifo_access_funcs') [enabled by default]
>    drivers/iio/kfifo_buf.c:166:2: error: unknown field 'release' specified in initializer
>      .release = &iio_kfifo_buffer_release,
>      ^
>    drivers/iio/kfifo_buf.c:166:2: warning: excess elements in struct initializer [enabled by default]
>    drivers/iio/kfifo_buf.c:166:2: warning: (near initialization for 'kfifo_access_funcs') [enabled by default]
>    drivers/iio/kfifo_buf.c: In function 'iio_kfifo_allocate':
>    drivers/iio/kfifo_buf.c:177:2: error: implicit declaration of function 'iio_buffer_init' [-Werror=implicit-function-declaration]
>      iio_buffer_init(&kf->buffer);
>      ^
>    drivers/iio/kfifo_buf.c:178:12: error: request for member 'attrs' in something not a structure or union
>      kf->buffer.attrs = &iio_kfifo_attribute_group;
>                ^
>    drivers/iio/kfifo_buf.c:178:2: warning: statement with no effect [-Wunused-value]
>      kf->buffer.attrs = &iio_kfifo_attribute_group;
>      ^
>    drivers/iio/kfifo_buf.c:179:12: error: request for member 'access' in something not a structure or union
>      kf->buffer.access = &kfifo_access_funcs;
>                ^
>    drivers/iio/kfifo_buf.c:179:2: warning: statement with no effect [-Wunused-value]
>      kf->buffer.access = &kfifo_access_funcs;
>      ^
>    drivers/iio/kfifo_buf.c:180:12: error: request for member 'length' in something not a structure or union
>      kf->buffer.length = 2;
>                ^
>    drivers/iio/kfifo_buf.c:180:2: warning: statement with no effect [-Wunused-value]
>      kf->buffer.length = 2;
>      ^
>    drivers/iio/kfifo_buf.c:182:2: warning: return from incompatible pointer type [enabled by default]
>      return &kf->buffer;
>      ^
>    drivers/iio/kfifo_buf.c: At top level:
>    drivers/iio/kfifo_buf.c:55:8: warning: 'IIO_BUFFER_ENABLE_ATTR' defined but not used [-Wunused-variable]
>     static IIO_BUFFER_ENABLE_ATTR;
>            ^
>    drivers/iio/kfifo_buf.c:56:8: warning: 'IIO_BUFFER_LENGTH_ATTR' defined but not used [-Wunused-variable]
>     static IIO_BUFFER_LENGTH_ATTR;
>            ^
>    cc1: some warnings being treated as errors
> 
> vim +/data_available +160 drivers/iio/kfifo_buf.c
> 
>    152		mutex_destroy(&kf->user_lock);
>    153		kfifo_free(&kf->kf);
>    154		kfree(kf);
>    155	}
>    156	
>    157	static const struct iio_buffer_access_funcs kfifo_access_funcs = {
>  > 158		.store_to = &iio_store_to_kfifo,
>    159		.read_first_n = &iio_read_first_n_kfifo,
>  > 160		.data_available = iio_kfifo_buf_data_available,
>    161		.request_update = &iio_request_update_kfifo,
>    162		.get_bytes_per_datum = &iio_get_bytes_per_datum_kfifo,
>    163		.set_bytes_per_datum = &iio_set_bytes_per_datum_kfifo,
> 
> ---
> 0-DAY kernel build testing backend              Open Source Technology Center
> http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
> 
