Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55907 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbbAJKdE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 10 Jan 2015 05:33:04 -0500
Message-ID: <54B0FFDB.1020402@kernel.org>
Date: Sat, 10 Jan 2015 10:32:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>, gregkh@linuxfoundation.org
CC: linux-iio@vger.kernel.org, rafael.j.wysocki@intel.com
Subject: Re: [PATCH] iio kmx61 / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
References: <1420796370-12158-1-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1420796370-12158-1-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/01/15 09:39, Daniel Baluta wrote:
> After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
> depending on CONFIG_PM_RUNTIME may now be changed to depend on
> CONFIG_PM.
> 
> Replace CONFIG_PM_RUNTIME with CONFIG_PM everywhere under
> drivers/iio/imu/kmx61.c
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Thanks Daniel, glad you tracked this down.  I was wondering why
the autobuilders were happy but it broke for Greg! (short memory
sometimes, given that patch was only a month ago).

Greg, as my tree is currently behind the point where Rafael did the big
patch series to fix this (and hence doesn't have the precursor patch)
there are two obvious solutions - either I rebase, or you take
this one patch directly as a merge fix.

Which would you prefer?

Jonathan
> ---
> This fixes build break when merging iio patches for 3.20
> into Greg's tree.
> http://marc.info/?l=linux-iio&m=142077015029632&w=2
> 
>  drivers/iio/imu/kmx61.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index 841b033..4e2605e 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -735,7 +735,7 @@ static int kmx61_setup_any_motion_interrupt(struct kmx61_data *data,
>   */
>  static int kmx61_set_power_state(struct kmx61_data *data, bool on, u8 device)
>  {
> -#ifdef CONFIG_PM_RUNTIME
> +#ifdef CONFIG_PM
>  	int ret;
>  
>  	if (device & KMX61_ACC) {
> @@ -1523,7 +1523,7 @@ static int kmx61_resume(struct device *dev)
>  }
>  #endif
>  
> -#ifdef CONFIG_PM_RUNTIME
> +#ifdef CONFIG_PM
>  static int kmx61_runtime_suspend(struct device *dev)
>  {
>  	struct kmx61_data *data = i2c_get_clientdata(to_i2c_client(dev));
> 

