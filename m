Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/8] iio: accel: mma9553: use unsigned counters
Date: Mon, 13 Apr 2015 13:54:52 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F19A4F5F1@irsmsx105.ger.corp.intel.com>
References: <1428503857-9081-1-git-send-email-irina.tirdea@intel.com>
 <1428503857-9081-3-git-send-email-irina.tirdea@intel.com>
 <55266447.50909@kernel.org>
In-Reply-To: <55266447.50909@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: 09 April, 2015 14:37
> To: Tirdea, Irina; linux-iio@vger.kernel.org; Hartmut Knaack
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/8] iio: accel: mma9553: use unsigned counters
>=20
> On 08/04/15 15:37, Irina Tirdea wrote:
> > Use unsigned counters instead of signed when all the
> > possible values are positive.
> >
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
> Does it make sense to carry this through to mma9551_transfer as well?
> Can't say I really care about this one. It's nice, but the compiler may
> well mess with the types used anyway given it can trivially tell their li=
mits...
>=20
> Still it does no harm so what the heck.  Certainly not a high
> priority change though.
Indeed, I should also change mma9551_transfer signature to reflect the chan=
ges for length.
Since this is just a "nice to have" change, will add it at the end of the s=
eries.

Thanks,
Irina
> > ---
> >  drivers/iio/accel/mma9551_core.c | 11 +++++------
> >  drivers/iio/accel/mma9553.c      |  8 ++++----
> >  2 files changed, 9 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma95=
51_core.c
> > index 54b3ae6..438cfed 100644
> > --- a/drivers/iio/accel/mma9551_core.c
> > +++ b/drivers/iio/accel/mma9551_core.c
> > @@ -387,8 +387,8 @@ EXPORT_SYMBOL(mma9551_read_status_word);
> >  int mma9551_read_config_words(struct i2c_client *client, u8 app_id,
> >  			     u16 reg, u8 len, u16 *buf)
> >  {
> > -	int ret, i;
> > -	int len_words =3D len / sizeof(u16);
> > +	int ret;
> > +	u8 i, len_words =3D len / sizeof(u16);
> >  	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS];
> >
> >  	ret =3D mma9551_transfer(client, app_id, MMA9551_CMD_READ_CONFIG,
> > @@ -422,8 +422,8 @@ EXPORT_SYMBOL(mma9551_read_config_words);
> >  int mma9551_read_status_words(struct i2c_client *client, u8 app_id,
> >  			      u16 reg, u8 len, u16 *buf)
> >  {
> > -	int ret, i;
> > -	int len_words =3D len / sizeof(u16);
> > +	int ret;
> > +	u8 i, len_words =3D len / sizeof(u16);
> >  	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS];
> >
> >  	ret =3D mma9551_transfer(client, app_id, MMA9551_CMD_READ_STATUS,
> > @@ -457,8 +457,7 @@ EXPORT_SYMBOL(mma9551_read_status_words);
> >  int mma9551_write_config_words(struct i2c_client *client, u8 app_id,
> >  			       u16 reg, u8 len, u16 *buf)
> >  {
> > -	int i;
> > -	int len_words =3D len / sizeof(u16);
> > +	u8 i, len_words =3D len / sizeof(u16);
> >  	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS];
> >
> >  	for (i =3D 0; i < len_words; i++)
> > diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> > index d095f81..9cfedb5 100644
> > --- a/drivers/iio/accel/mma9553.c
> > +++ b/drivers/iio/accel/mma9553.c
> > @@ -184,7 +184,7 @@ struct mma9553_data {
> >  	struct mutex mutex;
> >  	struct mma9553_conf_regs conf;
> >  	struct mma9553_event events[MMA9553_EVENTS_INFO_SIZE];#define MMA9551=
_APPID_RCS		0x17
> +#define MMA9551_APPID_RSC		0x17
> > -	int num_events;
> > +	u8 num_events;
> >  	u8 gpio_bitnum;
> >  	/*
> >  	 * This is used for all features that depend on step count:
> > @@ -225,7 +225,7 @@ static enum iio_modifier mma9553_activity_to_mod(en=
um activity_level activity)
> >
> >  static void mma9553_init_events(struct mma9553_data *data)
> >  {
> > -	int i;
> > +	u8 i;
> >
> >  	data->num_events =3D MMA9553_EVENTS_INFO_SIZE;
> >  	for (i =3D 0; i < data->num_events; i++) {
> > @@ -239,7 +239,7 @@ static struct mma9553_event *mma9553_get_event(stru=
ct mma9553_data *data,
> >  					       enum iio_modifier mod,
> >  					       enum iio_event_direction dir)
> >  {
> > -	int i;
> > +	u8 i;
> >
> >  	for (i =3D 0; i < data->num_events; i++)
> >  		if (data->events[i].info->type =3D=3D type &&
> > @@ -254,7 +254,7 @@ static bool mma9553_is_any_event_enabled(struct mma=
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
