Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752775AbeDUOyB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 10:54:01 -0400
Date: Sat, 21 Apr 2018 15:53:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] iio: hid-sensor-trigger: Fix sometimes not powering up
 the sensor after resume
Message-ID: <20180421155356.30a6ad75@archlinux>
In-Reply-To: <dc28cdda-7e80-1d77-dd29-714b87eb0cbd@redhat.com>
References: <20180414150909.14955-1-hdegoede@redhat.com>
        <20180415155809.31a45744@archlinux>
        <1523831646.3792.1.camel@linux.intel.com>
        <dc28cdda-7e80-1d77-dd29-714b87eb0cbd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 16 Apr 2018 07:22:50 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 16-04-18 00:34, Srinivas Pandruvada wrote:
> > On Sun, 2018-04-15 at 15:58 +0100, Jonathan Cameron wrote:  
> >> On Sat, 14 Apr 2018 17:09:09 +0200
> >> Hans de Goede <hdegoede@redhat.com> wrote:
> >>  
> >>> hid_sensor_set_power_work() powers the sensors back up after a
> >>> resume
> >>> based on the user_requested_state atomic_t.
> >>>
> >>> But hid_sensor_power_state() treats this as a boolean flag, leading
> >>> to
> >>> the following problematic scenario:
> >>>
> >>> 1) Some app starts using the iio-sensor in buffered / triggered
> >>> mode,
> >>>     hid_sensor_data_rdy_trigger_set_state(true) gets called, setting
> >>>     user_requested_state to 1.
> >>> 2) Something directly accesses a _raw value through sysfs, leading
> >>>     to a call to hid_sensor_power_state(true) followed by
> >>>     hid_sensor_power_state(false) call, this sets
> >>> user_requested_state
> >>>     to 1 followed by setting it to 0.
> >>> 3) Suspend/resume the machine, hid_sensor_set_power_work() now does
> >>>     NOT power the sensor back up because user_requested_state
> >>> (wrongly)
> >>>     is 0. Which stops the app using the sensor in buffered mode from
> >>>     receiving any new values.
> >>>
> >>> This commit changes user_requested_state to a counter tracking how
> >>> many
> >>> times hid_sensor_power_state(true) was called instead, fixing this.
> >>>
> >>> Cc: Bastien Nocera <hadess@hadess.net>
> >>> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> >>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>  
> > 
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > 
> > Which App is doing like this?  
> 
> No app, just something I noticed while manually testing the
> accelerometer while iio-sensor-proxy was also active.
> 
Applied to the fixes-togreg branch of iio.git and marked for stable.
Thanks,

Jonathan

> Regards,
> 
> Hans
> 
> 
> 
> > 
> > Thanks,
> > Srinivas
> > 
> >   
> >>
> >> Looks sensible to me.
> >>
> >> I'll give it a few days at least though for others to comment.
> >>
> >> Thanks,
> >>
> >> Jonathan
> >>  
> >>> ---
> >>>   drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 8 ++++----
> >>>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> >>> b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> >>> index cfb6588565ba..4905a997a7ec 100644
> >>> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> >>> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> >>> @@ -178,14 +178,14 @@ int hid_sensor_power_state(struct
> >>> hid_sensor_common *st, bool state)
> >>>   #ifdef CONFIG_PM
> >>>   	int ret;
> >>>   
> >>> -	atomic_set(&st->user_requested_state, state);
> >>> -
> >>>   	if (atomic_add_unless(&st->runtime_pm_enable, 1, 1))
> >>>   		pm_runtime_enable(&st->pdev->dev);
> >>>   
> >>> -	if (state)
> >>> +	if (state) {
> >>> +		atomic_inc(&st->user_requested_state);
> >>>   		ret = pm_runtime_get_sync(&st->pdev->dev);
> >>> -	else {
> >>> +	} else {
> >>> +		atomic_dec(&st->user_requested_state);
> >>>   		pm_runtime_mark_last_busy(&st->pdev->dev);
> >>>   		pm_runtime_use_autosuspend(&st->pdev->dev);
> >>>   		ret = pm_runtime_put_autosuspend(&st->pdev->dev);  
> >>
> >>  

