Return-Path: <SRS0=AjrS=6J=linaro.org=lee.jones@kernel.org>
Date: Thu, 6 Jul 2017 08:09:13 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Jack Andersen <jackoalan@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v5 3/3] mfd: dln2: Send restart command if HW init fails
Message-ID: <20170706070913.qh2ztrvbvi7gy5co@dell>
References: <1499289168-14392-1-git-send-email-jackoalan@gmail.com>
 <1499289168-14392-3-git-send-email-jackoalan@gmail.com>
 <CAPHBK3bnoUNXHdOwswGRDkiwHZSh6K1fRdJaTHDzaQwL_kP=Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAPHBK3bnoUNXHdOwswGRDkiwHZSh6K1fRdJaTHDzaQwL_kP=Bw@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, 05 Jul 2017, Jack Andersen wrote:

> I have mixed feelings about making this patch. The device appears to
> lose its ability to send command responses when the driver
> unexpectedly goes offline (probably overflowing an internal send
> buffer).
> 
> The restart command is a send-only way to recover the device.
> What concerns me is if there's another issue causing init to fail and
> a restart doesn't fix, this will trigger an endless probe loop. I'm
> not sure if there's a better way to discern this condition.

Why does dln2_restart() cause an unbind/bind?

> On 5 July 2017 at 11:12, Jack Andersen <jackoalan@gmail.com> wrote:
> > There's an issue with reinitializing DLN2 hardware if ADC channel event
> > configurations aren't reset before suspending the driver. A physical reconnect
> > of the device solves the problem, but restarting the machine without a power
> > cycle leaves the device state inconsistent.
> >
> > This patch transmits a restart command in the event of a failed init.
> > To the kernel's perspective, this is the rough equivalent of a disconnect and
> > reconnect, so another probe occurs shortly afterwards.
> >
> > Signed-off-by: Jack Andersen <jackoalan@gmail.com>
> > ---
> >  drivers/mfd/dln2.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
> > index a22ab8c..1eb0056 100644
> > --- a/drivers/mfd/dln2.c
> > +++ b/drivers/mfd/dln2.c
> > @@ -40,6 +40,7 @@ struct dln2_response {
> >  #define DLN2_GENERIC_CMD(cmd)          DLN2_CMD(cmd, DLN2_GENERIC_MODULE_ID)
> >  #define CMD_GET_DEVICE_VER             DLN2_GENERIC_CMD(0x30)
> >  #define CMD_GET_DEVICE_SN              DLN2_GENERIC_CMD(0x31)
> > +#define CMD_RESTART                    DLN2_GENERIC_CMD(0x43)
> >
> >  #define DLN2_HW_ID                     0x200
> >  #define DLN2_USB_TIMEOUT               200     /* in ms */
> > @@ -531,6 +532,12 @@ int dln2_transfer(struct platform_device *pdev, u16 cmd,
> >  }
> >  EXPORT_SYMBOL(dln2_transfer);
> >
> > +static int dln2_restart(struct dln2_dev *dln2)
> > +{
> > +       return _dln2_transfer(dln2, DLN2_HANDLE_CTRL, CMD_RESTART,
> > +                             NULL, 0, NULL, NULL);
> > +}
> > +
> >  static int dln2_check_hw(struct dln2_dev *dln2)
> >  {
> >         int ret;
> > @@ -782,7 +789,9 @@ static int dln2_probe(struct usb_interface *interface,
> >
> >         ret = dln2_hw_init(dln2);
> >         if (ret < 0) {
> > -               dev_err(dev, "failed to initialize hardware\n");
> > +               dev_err(dev,
> > +                       "failed to initialize hardware; attempting restart\n");
> > +               dln2_restart(dln2);
> >                 goto out_stop_rx;
> >         }
> >
> >

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
