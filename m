Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dogaru,
 Vlad" <vlad.dogaru@intel.com>
Subject: RE: [PATCH v2 17/17] iio: accel: mma9553: use unsigned counters
Date: Tue, 23 Jun 2015 14:17:19 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0616F8@irsmsx105.ger.corp.intel.com>
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
 <1428939664-12503-18-git-send-email-irina.tirdea@intel.com>
 <557D97F2.8080603@kernel.org>
In-Reply-To: <557D97F2.8080603@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: 14 June, 2015 18:04
> To: Tirdea, Irina; linux-iio@vger.kernel.org; Hartmut Knaack
> Cc: linux-kernel@vger.kernel.org; Dogaru, Vlad
> Subject: Re: [PATCH v2 17/17] iio: accel: mma9553: use unsigned counters
>=20
> On 13/04/15 16:41, Irina Tirdea wrote:
> > Use unsigned counters instead of signed when all the
> > possible values are positive.
> >
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
> Hmm. I'm actually going to drop this one.  I'm not sure
> there is a significant gain to be had by using minimal
> sized integers as loop iterators.
>=20
> int is just fine.
>=20

Fair enough, wasn't sure about this one either.

Thanks,
Irina

> Jonathan
> > ---
> >  drivers/iio/accel/mma9551_core.c | 12 +++++++-----
> >  drivers/iio/accel/mma9553.c      |  8 ++++----
> >  2 files changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma95=
51_core.c
> > index c34c5ce..44b8243 100644
> > --- a/drivers/iio/accel/mma9551_core.c
> > +++ b/drivers/iio/accel/mma9551_core.c
> > @@ -115,8 +115,8 @@ struct mma9551_version_info {
> >
> >  static int mma9551_transfer(struct i2c_client *client,
> >  			    u8 app_id, u8 command, u16 offset,
> > -			    u8 *inbytes, int num_inbytes,
> > -			    u8 *outbytes, int num_outbytes)
> > +			    u8 *inbytes, u8 num_inbytes,
> > +			    u8 *outbytes, u8 num_outbytes)
> >  {
> >  	struct mma9551_mbox_request req;
> >  	struct mma9551_mbox_response rsp;
> > @@ -387,7 +387,8 @@ EXPORT_SYMBOL(mma9551_read_status_word);
> >  int mma9551_read_config_words(struct i2c_client *client, u8 app_id,
> >  			      u16 reg, u8 len, u16 *buf)
> >  {
> > -	int ret, i;
> > +	int ret;
> > +	u8 i;
> >  	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS / 2];
> >
> >  	if (len > ARRAY_SIZE(be_buf)) {
> > @@ -426,7 +427,8 @@ EXPORT_SYMBOL(mma9551_read_config_words);
> >  int mma9551_read_status_words(struct i2c_client *client, u8 app_id,
> >  			      u16 reg, u8 len, u16 *buf)
> >  {
> > -	int ret, i;
> > +	int ret;
> > +	u8 i;
> >  	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS / 2];
> >
> >  	if (len > ARRAY_SIZE(be_buf)) {
> > @@ -465,7 +467,7 @@ EXPORT_SYMBOL(mma9551_read_status_words);
> >  int mma9551_write_config_words(struct i2c_client *client, u8 app_id,
> >  			       u16 reg, u8 len, u16 *buf)
> >  {
> > -	int i;
> > +	u8 i;
> >  	__be16 be_buf[(MMA9551_MAX_MAILBOX_DATA_REGS - 1) / 2];
> >
> >  	if (len > ARRAY_SIZE(be_buf)) {
> > diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> > index a605280..ad587ec 100644
> > --- a/drivers/iio/accel/mma9553.c
> > +++ b/drivers/iio/accel/mma9553.c
> > @@ -189,7 +189,7 @@ struct mma9553_data {
> >  	struct mutex mutex;
> >  	struct mma9553_conf_regs conf;
> >  	struct mma9553_event events[MMA9553_EVENTS_INFO_SIZE];
> > -	int num_events;
> > +	u8 num_events;
> >  	u8 gpio_bitnum;
> >  	/*
> >  	 * This is used for all features that depend on step count:
> > @@ -230,7 +230,7 @@ static enum iio_modifier mma9553_activity_to_mod(en=
um activity_level activity)
> >
> >  static void mma9553_init_events(struct mma9553_data *data)
> >  {
> > -	int i;
> > +	u8 i;
> >
> >  	data->num_events =3D MMA9553_EVENTS_INFO_SIZE;
> >  	for (i =3D 0; i < data->num_events; i++) {
> > @@ -244,7 +244,7 @@ static struct mma9553_event *mma9553_get_event(stru=
ct mma9553_data *data,
> >  					       enum iio_modifier mod,
> >  					       enum iio_event_direction dir)
> >  {
> > -	int i;
> > +	u8 i;
> >
> >  	for (i =3D 0; i < data->num_events; i++)
> >  		if (data->events[i].info->type =3D=3D type &&
> > @@ -259,7 +259,7 @@ static bool mma9553_is_any_event_enabled(struct mma=
9553_data *data,
> >  					 bool check_type,
> >  					 enum iio_chan_type type)
> >  {
> > -	int i;
> > +	u8 i;
> >
> >  	for (i =3D 0; i < data->num_events; i++)
> >  		if ((check_type && data->events[i].info->type =3D=3D type &&
> >
