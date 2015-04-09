Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51474 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932788AbbDILge (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 07:36:34 -0400
Message-ID: <55266447.50909@kernel.org>
Date: Thu, 09 Apr 2015 12:36:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] iio: accel: mma9553: use unsigned counters
References: <1428503857-9081-1-git-send-email-irina.tirdea@intel.com> <1428503857-9081-3-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428503857-9081-3-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/04/15 15:37, Irina Tirdea wrote:
> Use unsigned counters instead of signed when all the
> possible values are positive.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
Does it make sense to carry this through to mma9551_transfer as well?
Can't say I really care about this one. It's nice, but the compiler may
well mess with the types used anyway given it can trivially tell their limits...

Still it does no harm so what the heck.  Certainly not a high
priority change though.
> ---
>  drivers/iio/accel/mma9551_core.c | 11 +++++------
>  drivers/iio/accel/mma9553.c      |  8 ++++----
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
> index 54b3ae6..438cfed 100644
> --- a/drivers/iio/accel/mma9551_core.c
> +++ b/drivers/iio/accel/mma9551_core.c
> @@ -387,8 +387,8 @@ EXPORT_SYMBOL(mma9551_read_status_word);
>  int mma9551_read_config_words(struct i2c_client *client, u8 app_id,
>  			     u16 reg, u8 len, u16 *buf)
>  {
> -	int ret, i;
> -	int len_words = len / sizeof(u16);
> +	int ret;
> +	u8 i, len_words = len / sizeof(u16);
>  	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS];
>  
>  	ret = mma9551_transfer(client, app_id, MMA9551_CMD_READ_CONFIG,
> @@ -422,8 +422,8 @@ EXPORT_SYMBOL(mma9551_read_config_words);
>  int mma9551_read_status_words(struct i2c_client *client, u8 app_id,
>  			      u16 reg, u8 len, u16 *buf)
>  {
> -	int ret, i;
> -	int len_words = len / sizeof(u16);
> +	int ret;
> +	u8 i, len_words = len / sizeof(u16);
>  	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS];
>  
>  	ret = mma9551_transfer(client, app_id, MMA9551_CMD_READ_STATUS,
> @@ -457,8 +457,7 @@ EXPORT_SYMBOL(mma9551_read_status_words);
>  int mma9551_write_config_words(struct i2c_client *client, u8 app_id,
>  			       u16 reg, u8 len, u16 *buf)
>  {
> -	int i;
> -	int len_words = len / sizeof(u16);
> +	u8 i, len_words = len / sizeof(u16);
>  	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS];
>  
>  	for (i = 0; i < len_words; i++)
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index d095f81..9cfedb5 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -184,7 +184,7 @@ struct mma9553_data {
>  	struct mutex mutex;
>  	struct mma9553_conf_regs conf;
>  	struct mma9553_event events[MMA9553_EVENTS_INFO_SIZE];#define MMA9551_APPID_RCS		0x17
+#define MMA9551_APPID_RSC		0x17
> -	int num_events;
> +	u8 num_events;
>  	u8 gpio_bitnum;
>  	/*
>  	 * This is used for all features that depend on step count:
> @@ -225,7 +225,7 @@ static enum iio_modifier mma9553_activity_to_mod(enum activity_level activity)
>  
>  static void mma9553_init_events(struct mma9553_data *data)
>  {
> -	int i;
> +	u8 i;
>  
>  	data->num_events = MMA9553_EVENTS_INFO_SIZE;
>  	for (i = 0; i < data->num_events; i++) {
> @@ -239,7 +239,7 @@ static struct mma9553_event *mma9553_get_event(struct mma9553_data *data,
>  					       enum iio_modifier mod,
>  					       enum iio_event_direction dir)
>  {
> -	int i;
> +	u8 i;
>  
>  	for (i = 0; i < data->num_events; i++)
>  		if (data->events[i].info->type == type &&
> @@ -254,7 +254,7 @@ static bool mma9553_is_any_event_enabled(struct mma9553_data *data,
>  					 bool check_type,
>  					 enum iio_chan_type type)
>  {
> -	int i;
> +	u8 i;
>  
>  	for (i = 0; i < data->num_events; i++)
>  		if ((check_type && data->events[i].info->type == type &&
> 

