Return-Path: <SRS0=VmHu=25=intel.com=fengguang.wu@kernel.org>
Date: Mon, 20 Mar 2017 15:22:28 +0800
From: kbuild test robot <lkp@intel.com>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: kbuild-all@01.org, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	alsa-devel@alsa-project.org, olivier moysan <olivier.moysan@st.com>,
	kernel@stlinux.com, linux-iio@vger.kernel.org,
	arnaud.pouliquen@st.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [alsa-devel] [PATCH v3 05/11] IIO: ADC: add stm32 DFSDM support
 for Sigma delta ADC
Message-ID: <201703201522.JY2oSEMe%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
In-Reply-To: <1489759704-30217-6-git-send-email-arnaud.pouliquen@st.com>
List-ID: <linux-iio@vger.kernel.org>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnaud,

[auto build test WARNING on asoc/for-next]
[also build test WARNING on v4.11-rc3]
[cannot apply to iio/togreg next-20170310]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Arnaud-Pouliquen/Add-STM32-DFSDM-support/20170320-133247
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/iio/hw_consumer.c:23:20: error: field 'buffer' has incomplete type
     struct iio_buffer buffer;
                       ^~~~~~
   In file included from include/asm-generic/bug.h:13:0,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/mmdebug.h:4,
                    from include/linux/gfp.h:4,
                    from include/linux/slab.h:14,
                    from drivers/iio/hw_consumer.c:3:
   drivers/iio/hw_consumer.c: In function 'iio_buffer_to_hw_consumer_buffer':
   include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/iio/hw_consumer.c:29:9: note: in expansion of macro 'container_of'
     return container_of(buffer, struct hw_consumer_buffer, buffer);
            ^~~~~~~~~~~~
   drivers/iio/hw_consumer.c: At top level:
   drivers/iio/hw_consumer.c:40:21: error: variable 'iio_hw_buf_access' has initializer but incomplete type
    static const struct iio_buffer_access_funcs iio_hw_buf_access = {
                        ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/hw_consumer.c:41:2: error: unknown field 'release' specified in initializer
     .release = &iio_hw_buf_release,
     ^
>> drivers/iio/hw_consumer.c:41:13: warning: excess elements in struct initializer
     .release = &iio_hw_buf_release,
                ^
   drivers/iio/hw_consumer.c:41:13: note: (near initialization for 'iio_hw_buf_access')
   drivers/iio/hw_consumer.c:42:2: error: unknown field 'modes' specified in initializer
     .modes = INDIO_BUFFER_HARDWARE,
     ^
   In file included from drivers/iio/hw_consumer.c:7:0:
>> include/linux/iio/iio.h:353:32: warning: excess elements in struct initializer
    #define INDIO_BUFFER_HARDWARE  0x08
                                   ^
>> drivers/iio/hw_consumer.c:42:11: note: in expansion of macro 'INDIO_BUFFER_HARDWARE'
     .modes = INDIO_BUFFER_HARDWARE,
              ^~~~~~~~~~~~~~~~~~~~~
   include/linux/iio/iio.h:353:32: note: (near initialization for 'iio_hw_buf_access')
    #define INDIO_BUFFER_HARDWARE  0x08
                                   ^
>> drivers/iio/hw_consumer.c:42:11: note: in expansion of macro 'INDIO_BUFFER_HARDWARE'
     .modes = INDIO_BUFFER_HARDWARE,
              ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/hw_consumer.c: In function 'iio_hw_consumer_get_buffer':
   drivers/iio/hw_consumer.c:66:2: error: implicit declaration of function 'iio_buffer_init' [-Werror=implicit-function-declaration]
     iio_buffer_init(&buf->buffer);
     ^~~~~~~~~~~~~~~
   drivers/iio/hw_consumer.c: In function 'iio_hw_consumer_alloc':
   drivers/iio/hw_consumer.c:110:3: error: implicit declaration of function 'iio_buffer_put' [-Werror=implicit-function-declaration]
      iio_buffer_put(&buf->buffer);
      ^~~~~~~~~~~~~~
   drivers/iio/hw_consumer.c: In function 'iio_hw_consumer_enable':
   drivers/iio/hw_consumer.c:135:9: error: implicit declaration of function 'iio_update_buffers' [-Werror=implicit-function-declaration]
      ret = iio_update_buffers(buf->indio_dev, &buf->buffer, NULL);
            ^~~~~~~~~~~~~~~~~~
   drivers/iio/hw_consumer.c: At top level:
   drivers/iio/hw_consumer.c:40:45: error: storage size of 'iio_hw_buf_access' isn't known
    static const struct iio_buffer_access_funcs iio_hw_buf_access = {
                                                ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/iio/buffer/industrialio-buffer-dma.c:17:0:
   include/linux/iio/buffer-dma.h:107:20: error: field 'buffer' has incomplete type
     struct iio_buffer buffer;
                       ^~~~~~
   drivers/iio/buffer/industrialio-buffer-dma.c: In function 'iio_buffer_block_release':
   drivers/iio/buffer/industrialio-buffer-dma.c:104:2: error: implicit declaration of function 'iio_buffer_put' [-Werror=implicit-function-declaration]
     iio_buffer_put(&block->queue->buffer);
     ^~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:13:0,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/mmdebug.h:4,
                    from include/linux/gfp.h:4,
                    from include/linux/slab.h:14,
                    from drivers/iio/buffer/industrialio-buffer-dma.c:8:
   drivers/iio/buffer/industrialio-buffer-dma.c: In function 'iio_buffer_to_queue':
   include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/iio/buffer/industrialio-buffer-dma.c:163:9: note: in expansion of macro 'container_of'
     return container_of(buf, struct iio_dma_buffer_queue, buffer);
            ^~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dma.c: In function 'iio_dma_buffer_alloc_block':
   drivers/iio/buffer/industrialio-buffer-dma.c:188:2: error: implicit declaration of function 'iio_buffer_get' [-Werror=implicit-function-declaration]
     iio_buffer_get(&queue->buffer);
     ^~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dma.c: In function 'iio_dma_buffer_read':
   drivers/iio/buffer/industrialio-buffer-dma.c:489:16: error: dereferencing pointer to incomplete type 'struct iio_buffer'
     if (n < buffer->bytes_per_datum)
                   ^~
   drivers/iio/buffer/industrialio-buffer-dma.c: In function 'iio_dma_buffer_init':
   drivers/iio/buffer/industrialio-buffer-dma.c:614:2: error: implicit declaration of function 'iio_buffer_init' [-Werror=implicit-function-declaration]
     iio_buffer_init(&queue->buffer);
     ^~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dma.c: In function 'iio_buffer_to_queue':
>> drivers/iio/buffer/industrialio-buffer-dma.c:164:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   cc1: some warnings being treated as errors
--
   In file included from drivers/iio/buffer/industrialio-buffer-dmaengine.c:17:0:
   include/linux/iio/buffer-dma.h:107:20: error: field 'buffer' has incomplete type
     struct iio_buffer buffer;
                       ^~~~~~
   In file included from include/asm-generic/bug.h:13:0,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/mmdebug.h:4,
                    from include/linux/gfp.h:4,
                    from include/linux/slab.h:14,
                    from drivers/iio/buffer/industrialio-buffer-dmaengine.c:8:
   drivers/iio/buffer/industrialio-buffer-dmaengine.c: In function 'iio_buffer_to_dmaengine_buffer':
   include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/iio/buffer/industrialio-buffer-dmaengine.c:43:9: note: in expansion of macro 'container_of'
     return container_of(buffer, struct dmaengine_buffer, queue.buffer);
            ^~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c: At top level:
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:109:21: error: variable 'iio_dmaengine_buffer_ops' has initializer but incomplete type
    static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
                        ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:110:2: error: unknown field 'read_first_n' specified in initializer
     .read_first_n = iio_dma_buffer_read,
     ^
>> drivers/iio/buffer/industrialio-buffer-dmaengine.c:110:18: warning: excess elements in struct initializer
     .read_first_n = iio_dma_buffer_read,
                     ^~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:110:18: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:111:2: error: unknown field 'set_bytes_per_datum' specified in initializer
     .set_bytes_per_datum = iio_dma_buffer_set_bytes_per_datum,
     ^
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:111:25: warning: excess elements in struct initializer
     .set_bytes_per_datum = iio_dma_buffer_set_bytes_per_datum,
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:111:25: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:112:2: error: unknown field 'set_length' specified in initializer
     .set_length = iio_dma_buffer_set_length,
     ^
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:112:16: warning: excess elements in struct initializer
     .set_length = iio_dma_buffer_set_length,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:112:16: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:113:2: error: unknown field 'request_update' specified in initializer
     .request_update = iio_dma_buffer_request_update,
     ^
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:113:20: warning: excess elements in struct initializer
     .request_update = iio_dma_buffer_request_update,
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:113:20: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:114:2: error: unknown field 'enable' specified in initializer
     .enable = iio_dma_buffer_enable,
     ^
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:114:12: warning: excess elements in struct initializer
     .enable = iio_dma_buffer_enable,
               ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:114:12: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:115:2: error: unknown field 'disable' specified in initializer
     .disable = iio_dma_buffer_disable,
     ^
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:115:13: warning: excess elements in struct initializer
     .disable = iio_dma_buffer_disable,
                ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:115:13: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:116:2: error: unknown field 'data_available' specified in initializer
     .data_available = iio_dma_buffer_data_available,
     ^
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:116:20: warning: excess elements in struct initializer
     .data_available = iio_dma_buffer_data_available,
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:116:20: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:117:2: error: unknown field 'release' specified in initializer
     .release = iio_dmaengine_buffer_release,
     ^
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:117:13: warning: excess elements in struct initializer
     .release = iio_dmaengine_buffer_release,
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:117:13: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:119:2: error: unknown field 'modes' specified in initializer
     .modes = INDIO_BUFFER_HARDWARE,
     ^
   In file included from drivers/iio/buffer/industrialio-buffer-dmaengine.c:15:0:
>> include/linux/iio/iio.h:353:32: warning: excess elements in struct initializer
    #define INDIO_BUFFER_HARDWARE  0x08
                                   ^
>> drivers/iio/buffer/industrialio-buffer-dmaengine.c:119:11: note: in expansion of macro 'INDIO_BUFFER_HARDWARE'
     .modes = INDIO_BUFFER_HARDWARE,
              ^~~~~~~~~~~~~~~~~~~~~
   include/linux/iio/iio.h:353:32: note: (near initialization for 'iio_dmaengine_buffer_ops')
    #define INDIO_BUFFER_HARDWARE  0x08
                                   ^
>> drivers/iio/buffer/industrialio-buffer-dmaengine.c:119:11: note: in expansion of macro 'INDIO_BUFFER_HARDWARE'
     .modes = INDIO_BUFFER_HARDWARE,
              ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:120:2: error: unknown field 'flags' specified in initializer
     .flags = INDIO_BUFFER_FLAG_FIXED_WATERMARK,
     ^
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:120:11: error: 'INDIO_BUFFER_FLAG_FIXED_WATERMARK' undeclared here (not in a function)
     .flags = INDIO_BUFFER_FLAG_FIXED_WATERMARK,
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:120:11: warning: excess elements in struct initializer
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:120:11: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio/buffer/industrialio-buffer-dmaengine.c: In function 'iio_dmaengine_buffer_free':
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:206:2: error: implicit declaration of function 'iio_buffer_put' [-Werror=implicit-function-declaration]
     iio_buffer_put(buffer);
     ^~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c: At top level:
   drivers/iio/buffer/industrialio-buffer-dmaengine.c:109:45: error: storage size of 'iio_dmaengine_buffer_ops' isn't known
    static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
                                                ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-dmaengine.c: In function 'iio_buffer_to_dmaengine_buffer':
>> drivers/iio/buffer/industrialio-buffer-dmaengine.c:44:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   cc1: some warnings being treated as errors
--
   In file included from drivers/iio//buffer/industrialio-buffer-dmaengine.c:17:0:
   include/linux/iio/buffer-dma.h:107:20: error: field 'buffer' has incomplete type
     struct iio_buffer buffer;
                       ^~~~~~
   In file included from include/asm-generic/bug.h:13:0,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/mmdebug.h:4,
                    from include/linux/gfp.h:4,
                    from include/linux/slab.h:14,
                    from drivers/iio//buffer/industrialio-buffer-dmaengine.c:8:
   drivers/iio//buffer/industrialio-buffer-dmaengine.c: In function 'iio_buffer_to_dmaengine_buffer':
   include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:43:9: note: in expansion of macro 'container_of'
     return container_of(buffer, struct dmaengine_buffer, queue.buffer);
            ^~~~~~~~~~~~
   drivers/iio//buffer/industrialio-buffer-dmaengine.c: At top level:
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:109:21: error: variable 'iio_dmaengine_buffer_ops' has initializer but incomplete type
    static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
                        ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:110:2: error: unknown field 'read_first_n' specified in initializer
     .read_first_n = iio_dma_buffer_read,
     ^
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:110:18: warning: excess elements in struct initializer
     .read_first_n = iio_dma_buffer_read,
                     ^~~~~~~~~~~~~~~~~~~
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:110:18: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:111:2: error: unknown field 'set_bytes_per_datum' specified in initializer
     .set_bytes_per_datum = iio_dma_buffer_set_bytes_per_datum,
     ^
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:111:25: warning: excess elements in struct initializer
     .set_bytes_per_datum = iio_dma_buffer_set_bytes_per_datum,
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:111:25: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:112:2: error: unknown field 'set_length' specified in initializer
     .set_length = iio_dma_buffer_set_length,
     ^
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:112:16: warning: excess elements in struct initializer
     .set_length = iio_dma_buffer_set_length,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:112:16: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:113:2: error: unknown field 'request_update' specified in initializer
     .request_update = iio_dma_buffer_request_update,
     ^
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:113:20: warning: excess elements in struct initializer
     .request_update = iio_dma_buffer_request_update,
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:113:20: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:114:2: error: unknown field 'enable' specified in initializer
     .enable = iio_dma_buffer_enable,
     ^
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:114:12: warning: excess elements in struct initializer
     .enable = iio_dma_buffer_enable,
               ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:114:12: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:115:2: error: unknown field 'disable' specified in initializer
     .disable = iio_dma_buffer_disable,
     ^
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:115:13: warning: excess elements in struct initializer
     .disable = iio_dma_buffer_disable,
                ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:115:13: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:116:2: error: unknown field 'data_available' specified in initializer
     .data_available = iio_dma_buffer_data_available,
     ^
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:116:20: warning: excess elements in struct initializer
     .data_available = iio_dma_buffer_data_available,
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:116:20: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:117:2: error: unknown field 'release' specified in initializer
     .release = iio_dmaengine_buffer_release,
     ^
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:117:13: warning: excess elements in struct initializer
     .release = iio_dmaengine_buffer_release,
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:117:13: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:119:2: error: unknown field 'modes' specified in initializer
     .modes = INDIO_BUFFER_HARDWARE,
     ^
   In file included from drivers/iio//buffer/industrialio-buffer-dmaengine.c:15:0:
>> include/linux/iio/iio.h:353:32: warning: excess elements in struct initializer
    #define INDIO_BUFFER_HARDWARE  0x08
                                   ^
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:119:11: note: in expansion of macro 'INDIO_BUFFER_HARDWARE'
     .modes = INDIO_BUFFER_HARDWARE,
              ^~~~~~~~~~~~~~~~~~~~~
   include/linux/iio/iio.h:353:32: note: (near initialization for 'iio_dmaengine_buffer_ops')
    #define INDIO_BUFFER_HARDWARE  0x08
                                   ^
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:119:11: note: in expansion of macro 'INDIO_BUFFER_HARDWARE'
     .modes = INDIO_BUFFER_HARDWARE,
              ^~~~~~~~~~~~~~~~~~~~~
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:120:2: error: unknown field 'flags' specified in initializer
     .flags = INDIO_BUFFER_FLAG_FIXED_WATERMARK,
     ^
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:120:11: error: 'INDIO_BUFFER_FLAG_FIXED_WATERMARK' undeclared here (not in a function)
     .flags = INDIO_BUFFER_FLAG_FIXED_WATERMARK,
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:120:11: warning: excess elements in struct initializer
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:120:11: note: (near initialization for 'iio_dmaengine_buffer_ops')
   drivers/iio//buffer/industrialio-buffer-dmaengine.c: In function 'iio_dmaengine_buffer_free':
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:206:2: error: implicit declaration of function 'iio_buffer_put' [-Werror=implicit-function-declaration]
     iio_buffer_put(buffer);
     ^~~~~~~~~~~~~~
   drivers/iio//buffer/industrialio-buffer-dmaengine.c: At top level:
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:109:45: error: storage size of 'iio_dmaengine_buffer_ops' isn't known
    static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
                                                ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio//buffer/industrialio-buffer-dmaengine.c: In function 'iio_buffer_to_dmaengine_buffer':
   drivers/iio//buffer/industrialio-buffer-dmaengine.c:44:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   cc1: some warnings being treated as errors

vim +/container_of +29 drivers/iio/hw_consumer.c

d5ca88eb Lars-Peter Clausen 2017-03-17   1  #include <linux/err.h>
d5ca88eb Lars-Peter Clausen 2017-03-17   2  #include <linux/export.h>
d5ca88eb Lars-Peter Clausen 2017-03-17  @3  #include <linux/slab.h>
d5ca88eb Lars-Peter Clausen 2017-03-17   4  #include <linux/mutex.h>
d5ca88eb Lars-Peter Clausen 2017-03-17   5  #include <linux/of.h>
d5ca88eb Lars-Peter Clausen 2017-03-17   6  
d5ca88eb Lars-Peter Clausen 2017-03-17   7  #include <linux/iio/iio.h>
d5ca88eb Lars-Peter Clausen 2017-03-17   8  #include "iio_core.h"
d5ca88eb Lars-Peter Clausen 2017-03-17   9  #include <linux/iio/machine.h>
d5ca88eb Lars-Peter Clausen 2017-03-17  10  #include <linux/iio/driver.h>
d5ca88eb Lars-Peter Clausen 2017-03-17  11  #include <linux/iio/consumer.h>
d5ca88eb Lars-Peter Clausen 2017-03-17  12  #include <linux/iio/hw_consumer.h>
d5ca88eb Lars-Peter Clausen 2017-03-17  13  #include <linux/iio/buffer.h>
d5ca88eb Lars-Peter Clausen 2017-03-17  14  
d5ca88eb Lars-Peter Clausen 2017-03-17  15  struct iio_hw_consumer {
d5ca88eb Lars-Peter Clausen 2017-03-17  16  	struct list_head buffers;
d5ca88eb Lars-Peter Clausen 2017-03-17  17  	struct iio_channel *channels;
d5ca88eb Lars-Peter Clausen 2017-03-17  18  };
d5ca88eb Lars-Peter Clausen 2017-03-17  19  
d5ca88eb Lars-Peter Clausen 2017-03-17  20  struct hw_consumer_buffer {
d5ca88eb Lars-Peter Clausen 2017-03-17  21  	struct list_head head;
d5ca88eb Lars-Peter Clausen 2017-03-17  22  	struct iio_dev *indio_dev;
d5ca88eb Lars-Peter Clausen 2017-03-17  23  	struct iio_buffer buffer;
d5ca88eb Lars-Peter Clausen 2017-03-17  24  };
d5ca88eb Lars-Peter Clausen 2017-03-17  25  
d5ca88eb Lars-Peter Clausen 2017-03-17  26  static struct hw_consumer_buffer *iio_buffer_to_hw_consumer_buffer(
d5ca88eb Lars-Peter Clausen 2017-03-17  27  	struct iio_buffer *buffer)
d5ca88eb Lars-Peter Clausen 2017-03-17  28  {
d5ca88eb Lars-Peter Clausen 2017-03-17 @29  	return container_of(buffer, struct hw_consumer_buffer, buffer);
d5ca88eb Lars-Peter Clausen 2017-03-17  30  }
d5ca88eb Lars-Peter Clausen 2017-03-17  31  
d5ca88eb Lars-Peter Clausen 2017-03-17  32  static void iio_hw_buf_release(struct iio_buffer *buffer)
d5ca88eb Lars-Peter Clausen 2017-03-17  33  {
d5ca88eb Lars-Peter Clausen 2017-03-17  34  	struct hw_consumer_buffer *hw_buf =
d5ca88eb Lars-Peter Clausen 2017-03-17  35  		iio_buffer_to_hw_consumer_buffer(buffer);
d5ca88eb Lars-Peter Clausen 2017-03-17  36  	kfree(hw_buf->buffer.scan_mask);
d5ca88eb Lars-Peter Clausen 2017-03-17  37  	kfree(hw_buf);
d5ca88eb Lars-Peter Clausen 2017-03-17  38  }
d5ca88eb Lars-Peter Clausen 2017-03-17  39  
d5ca88eb Lars-Peter Clausen 2017-03-17 @40  static const struct iio_buffer_access_funcs iio_hw_buf_access = {
d5ca88eb Lars-Peter Clausen 2017-03-17 @41  	.release = &iio_hw_buf_release,
d5ca88eb Lars-Peter Clausen 2017-03-17 @42  	.modes = INDIO_BUFFER_HARDWARE,
d5ca88eb Lars-Peter Clausen 2017-03-17  43  };
d5ca88eb Lars-Peter Clausen 2017-03-17  44  
d5ca88eb Lars-Peter Clausen 2017-03-17  45  static struct hw_consumer_buffer *iio_hw_consumer_get_buffer(

:::::: The code at line 29 was first introduced by commit
:::::: d5ca88ebd75256ba43b57c82dfa9a3cbeb3cacf7 iio: Add hardware consumer support

:::::: TO: Lars-Peter Clausen <lars@metafoo.de>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--AqsLC8rIMeq19msA
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--AqsLC8rIMeq19msA--
