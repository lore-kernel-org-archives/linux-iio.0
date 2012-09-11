Return-Path: <pmeerw@pmeerw.net>
Date: Tue, 11 Sep 2012 10:35:04 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: =?UTF-8?Q?Martin_Li=C5=A1ka?= <marxin.liska@gmail.com>
cc: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
    Jonathan Cameron <jic23@kernel.org>
Subject: Re: ACPI ambient light sensor
In-Reply-To: <CAObPJ3ORe_MGbmEHzZ4SGqZkn3HCQs+ocSw=Ttb7LbCTNCDkAQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.01.1209111032390.3985@pmeerw.net>
References: <CAObPJ3PctmLP56NvmLvJd+4w9e4xeOGSyz24FyBDXBQQVhDhxQ@mail.gmail.com> <201207082228.14318.marex@denx.de> <4FFADCC2.6080006@cam.ac.uk> <CAObPJ3ORe_MGbmEHzZ4SGqZkn3HCQs+ocSw=Ttb7LbCTNCDkAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> +static irqreturn_t acpi_als_trigger_handler(int irq, void *p)
> +{
> + printk("XXXX: TRIGGER handler called :)");

should put
iio_trigger_notify_done(idev->trig);
here

> +
> + return IRQ_HANDLED;
> +
> + struct iio_poll_func *pf = p;
> + struct iio_dev *idev = pf->indio_dev;
> + struct acpi_als_chip *chip = iio_priv(idev);
> + struct iio_buffer *buffer = idev->buffer;
> + int i, j = 0;
> +
> + /* TODO: remove */
> + u8 b[64];
> +
> + for (i = 0; i < idev->masklength; i++) {
> + if (!test_bit(i, idev->active_scan_mask))
> + continue;
> +
> + // TODO: read
> + j++;
> + }
> +
> + if (idev->scan_timestamp) {
> + s64 *timestamp = (s64 *)((u8 *)b +
> + ALIGN(j, sizeof(s64)));
> + *timestamp = pf->timestamp;
> + }
> +
> + buffer->access->store_to(buffer, (u8 *)b, pf->timestamp);
> +
> + iio_trigger_notify_done(idev->trig);
> +
> + return IRQ_HANDLED;
> +}

--

Peter Meerwald
+43-664-2444418 (mobile)
