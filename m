Return-Path: <vlad.dogaru@intel.com>
Date: Thu, 9 Apr 2015 16:36:12 +0300
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	adriana.reus@intel.com
Subject: Re: [PATCH] iio: accel: kxcjk1013: allow using an external trigger
Message-ID: <20150409133612.GA11961@vdogaru>
References: <1428062582-3092-1-git-send-email-vlad.dogaru@intel.com>
 <CAEnQRZBEtQD5rAYDThpkDa-2mJU81fXaaz+Hk5c0W8ThxE7Bhg@mail.gmail.com>
 <55267CBF.7030106@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55267CBF.7030106@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Apr 09, 2015 at 02:21:03PM +0100, Jonathan Cameron wrote:
> On 06/04/15 08:24, Daniel Baluta wrote:
> > On Fri, Apr 3, 2015 at 3:03 PM, Vlad Dogaru <vlad.dogaru@intel.com> wrote:
> >> In its present state, the driver mandates that its buffer only be
> >> triggered by one of the device's own triggers (data ready or any
> >> motion).  This is not always desirable, for example because the
> >> interrupt pins may not be wired in.
> >>
> >> Patch the driver to be able to accept using an external trigger, such as
> >> one based on hrtimer.  When using such a trigger, we need to ensure that
> >> the device is powered on when the buffer is started.  We do that by
> >> setting setup_ops for the buffer.
> >>
> >> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
> > 
> > Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
> Applied to the togreg branch of iio.git.  Initially pushed out as testing
> for the autobuilders to play with it.
> 
> Thanks,
> 
> Jonathan
> > 
> >> ---
> >>
> >> I used the hrtimer-based trigger patches that Daniel sent earlier this week to
> >> test these changes.
> Feel free to add a tested-by to that patch then if you haven't already!

I'm reluctant to do that since Daniel has posted a v3 for the hrtimer
patchset and I've been using the v2 ones.  Sure, the core functionality
is the same, but the userspace interface differs.

> >>
> >>  drivers/iio/accel/kxcjk-1013.c | 38 +++++++++++++++++++++++---------------
> >>  1 file changed, 23 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> >> index a98b5d2..7ae1bdb 100644
> >> --- a/drivers/iio/accel/kxcjk-1013.c
> >> +++ b/drivers/iio/accel/kxcjk-1013.c
> >> @@ -875,15 +875,18 @@ static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
> >>         return 0;
> >>  }
> >>
> >> -static int kxcjk1013_validate_trigger(struct iio_dev *indio_dev,
> >> -                                     struct iio_trigger *trig)
> >> +static int kxcjk1013_buffer_preenable(struct iio_dev *indio_dev)
> >>  {
> >>         struct kxcjk1013_data *data = iio_priv(indio_dev);
> >>
> >> -       if (data->dready_trig != trig && data->motion_trig != trig)
> >> -               return -EINVAL;
> >> +       return kxcjk1013_set_power_state(data, true);
> >> +}
> >>
> >> -       return 0;
> >> +static int kxcjk1013_buffer_postdisable(struct iio_dev *indio_dev)
> >> +{
> >> +       struct kxcjk1013_data *data = iio_priv(indio_dev);
> >> +
> >> +       return kxcjk1013_set_power_state(data, false);
> >>  }
> >>
> >>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
> >> @@ -935,6 +938,13 @@ static const struct iio_chan_spec kxcjk1013_channels[] = {
> >>         IIO_CHAN_SOFT_TIMESTAMP(3),
> >>  };
> >>
> >> +static const struct iio_buffer_setup_ops kxcjk1013_buffer_setup_ops = {
> >> +       .preenable              = kxcjk1013_buffer_preenable,
> >> +       .postenable             = iio_triggered_buffer_postenable,
> >> +       .postdisable            = kxcjk1013_buffer_postdisable,
> >> +       .predisable             = iio_triggered_buffer_predisable,
> >> +};
> >> +
> >>  static const struct iio_info kxcjk1013_info = {
> >>         .attrs                  = &kxcjk1013_attrs_group,
> >>         .read_raw               = kxcjk1013_read_raw,
> >> @@ -943,7 +953,6 @@ static const struct iio_info kxcjk1013_info = {
> >>         .write_event_value      = kxcjk1013_write_event,
> >>         .write_event_config     = kxcjk1013_write_event_config,
> >>         .read_event_config      = kxcjk1013_read_event_config,
> >> -       .validate_trigger       = kxcjk1013_validate_trigger,
> >>         .driver_module          = THIS_MODULE,
> >>  };
> >>
> >> @@ -1276,16 +1285,15 @@ static int kxcjk1013_probe(struct i2c_client *client,
> >>                         data->motion_trig = NULL;
> >>                         goto err_trigger_unregister;Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
> >>                 }
> >> +       }
> >>
> >> -               ret = iio_triggered_buffer_setup(indio_dev,
> >> -                                               &iio_pollfunc_store_time,
> >> -                                               kxcjk1013_trigger_handler,
> >> -                                               NULL);
> >> -               if (ret < 0) {
> >> -                       dev_err(&client->dev,
> >> -                                       "iio triggered buffer setup failed\n");
> >> -                       goto err_trigger_unregister;
> >> -               }
> >> +       ret = iio_triggered_buffer_setup(indio_dev,
> >> +                                        &iio_pollfunc_store_time,
> >> +                                        kxcjk1013_trigger_handler,
> >> +                                        &kxcjk1013_buffer_setup_ops);
> >> +       if (ret < 0) {
> >> +               dev_err(&client->dev, "iio triggered buffer setup failed\n");
> >> +               goto err_trigger_unregister;
> >>         }
> >>
> >>         ret = iio_device_register(indio_dev);
> >> --
> >> 1.9.1
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
