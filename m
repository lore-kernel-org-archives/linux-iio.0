Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35840 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632Ab2KXQXw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 24 Nov 2012 11:23:52 -0500
Message-ID: <50B0F495.6040409@kernel.org>
Date: Sat, 24 Nov 2012 16:23:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: Denis Ciocca <denis.ciocca@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	Pavel Machek <pavel@denx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"burman.yan@gmail.com" <burman.yan@gmail.com>
Subject: Re: STMicroelectronics accelerometers driver.
References: <5072F3B9.4050309@st.com> <5073260C.3010506@metafoo.de> <20121008195007.GA32042@elf.ucw.cz> <507338B5.60307@metafoo.de> <665718a4-de6b-4d09-ba80-35705fcf2595@email.android.com> <CAEE_umojW5OyB3yGgE54wH7_k__dBu9=Yew_0tCCf5--=C2g5g@mail.gmail.com> <507D9EA3.4070009@metafoo.de> <5085128C.7020507@st.com> <50858B44.2080006@kernel.org> <5087E2A8.4070304@st.com> <508A7DA6.7050505@metafoo.de> <508E4492.8080000@st.com> <508E48D1.3000703@metafoo.de> <508E5978.5000907@st.com> <508E5AD5.1040907@metafoo.de> <50914366.4090000@st.com> <5091546D.9000601@metafoo.de> <CAEE_umoKvv9ciBfUSahDqsmcbHi9W=93o5YSpE-vxUduCmqWSQ@mail.gmail.com> <50982F71.3060606@kernel.org> <5098F065.1090009@st.com> <50A12D8C.6040207@st.com> <50A14485.2060902@kernel.org> <50A26967.4050102@st.com> <50A8E083.1050908@kernel.org> <50AFA000.3040906@st.com>
In-Reply-To: <50AFA000.3040906@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/23/2012 04:10 PM, Denis CIOCCA wrote:
> Hi Jonathan and Lars-Peter,
>
> I have modified the source code but I am not sure if the spi dma code
> management is correctly because this part is new for me.
Comments on that below. It's much simpler than what you have done.
>
> About the complexity of channels management in the buffer code, I think
> the code is not too difficult and it is possible leave this code as now.
> Are you agree?
Yeah, that bit is fine.
>
>
> I attach the patch.
>
> Best regards,
>
> Denis
>
>

...
> diff --git a/drivers/iio/accel/st_accel_spi.c
> b/drivers/iio/accel/st_accel_spi.c
> new file mode 100644
> index 0000000..fbc199d
> --- /dev/null
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -0,0 +1,178 @@
> +/*
> + * STMicroelectronics accelerometers driver
> + *
> + * Copyright 2012 STMicroelectronics Inc.
> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +
> +#include <linux/iio/accel/st_accel.h>
> +
> +
> +#define ACC_SPI_READ           0x80;
> +#define ACC_SPI_MULTIREAD      0xc0
> +
> +static int st_accel_spi_read(struct st_accel_data *adata,
> +                                               u8 reg_addr, int len, u8 *data)
> +{
> +       struct spi_message msg;
> +       int err;
This is on the stack. Needs to be on the heap to ensure alignment
and either it has to be on it's own or alignment to a cacheline
must be enforced.

u8 *tx = kmalloc(sizeof(tx), GFP_KERNEL);

Also note that data must also be dynamically allocated (from a quick
look it is).
> +       u8 tx;
> +
> +       struct spi_transfer xfers[] = {
> +               {
> +                       .tx_buf = &tx,
> +                       .bits_per_word = 8,
> +                       .len = 1,
> +               },
> +               {
> +                       .rx_buf = data,
> +                       .bits_per_word = 8,
> +                       .len = len,
> +               }
> +       };
> +
> +       if ((adata->multiread_bit == true) && (len > 1))
> +               tx = reg_addr | ACC_SPI_MULTIREAD;
> +       else
> +               tx = reg_addr | ACC_SPI_READ;
> +
> +       spi_message_init(&msg);
> +       spi_message_add_tail(&xfers[0], &msg);
> +       spi_message_add_tail(&xfers[1], &msg);
> +       err = spi_sync(to_spi_device(adata->dev), &msg);
> +       if (err)
> +               goto acc_spi_read_error;
> +
> +       return len;
> +
> +acc_spi_read_error:
> +       return err;
> +}
> +
> +static int st_accel_spi_read_byte(struct st_accel_data *adata,
> +                                               u8 reg_addr, u8 *res_byte)
> +{
> +       return st_accel_spi_read(adata, reg_addr, 1, res_byte);
> +}
> +
> +static int st_accel_spi_read_multiple_byte(struct st_accel_data *adata,
> +                                               u8 reg_addr, int len, u8 *data)
> +{
> +       return st_accel_spi_read(adata, reg_addr, len, data);
> +}
> +
> +static int st_accel_spi_write_byte(struct st_accel_data *adata,
> +                                                       u8 reg_addr, u8 data)
> +{
> +       struct spi_message msg;
> +       int err;
> +       u8 tx[2], *data_write;
> +

Errr.  Not sure what you are up to. It's simply a case of allocating
tx on the heap, not the stack.  This is true for anything that goes
in tx_buf or rx_buf of an spi_transfer structure;


struct spi_transfer xfers = {
       .bits_per_word = 8,
       .len = 2,
};
u8 *tx;

tx = kmalloc(sizeof(u8)*2);
tx[0] = reg_addr;
tx[1] = data_write;
xfers.tx_buf = tx;
...


kfree(tx);
}
> +       struct spi_transfer xfers = {
> +               .tx_buf = tx,
> +               .bits_per_word = 8,
> +               .len = 2,
> +       };
> +
> +       data_write = kmalloc(sizeof(*data_write), GFP_KERNEL);
> +       if (data_write == NULL) {
> +               err = -ENOMEM;
> +               goto alloc_memory_error;
> +       }
> +       *data_write = data;
> +
> +       tx[0] = reg_addr;
> +       tx[1] = *data_write;
> +       spi_message_init(&msg);
> +       spi_message_add_tail(&xfers, &msg);
> +       err = spi_sync(to_spi_device(adata->dev), &msg);
> +       kfree(data_write);
> +
> +alloc_memory_error:
> +       return err;
> +}
> +
...
