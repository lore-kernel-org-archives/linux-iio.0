Return-Path: <SRS0=HVuF=MI=gmail.com=songqiang1304521@kernel.org>
Date: Wed, 26 Sep 2018 10:24:27 +0800
From: Song Qiang <songqiang1304521@gmail.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	robh+dt@kernel.org, mark.rutland@arm.com, preid@electromag.com.au,
	rtresidd@electromag.com.au, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: magnetometer: Add driver support for PNI RM3100
Message-ID: <20180926022427.GA7447@Eros>
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
 <20180925031724.21399-2-songqiang1304521@gmail.com>
 <20180925175018.GA5643@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180925175018.GA5643@himanshu-Vostro-3559>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Sep 25, 2018 at 11:20:18PM +0530, Himanshu Jha wrote:
> On Tue, Sep 25, 2018 at 11:17:24AM +0800, Song Qiang wrote:
> > PNI RM3100 is a high resolution, large signal immunity magnetometer,
> > composed of 3 single sensors and a processing chip with MagI2C Interface.
> > 
> > Following functions are available:
> > - Single-shot measurement from
> >   /sys/bus/iio/devices/iio:deviceX/in_magn_{axis}_raw
> > - Triggerd buffer measurement.
> > - Both i2c and spi interface are supported.
> > - Both interrupt and polling measurement is supported, depands on if
> 							 depends
> 

...

> +
> > +static int rm3100_wait_measurement(struct rm3100_data *data)
> > +{
> > +	struct regmap *regmap = data->regmap;
> > +	unsigned int val;
> > +	int tries = 20;
> > +	int ret;
> > +
> > +	/*
> > +	 * A read cycle of 400kbits i2c; bus is about 20us, plus the time
> 				      ; was mistakenly added ?
> 

Hi Himanshu,

Oops, it shouldn't be there.

> > +	 * used for scheduling, a read cycle of fast mode of this device
> > +	 * can reach 1.7ms, it may be possible for data to arrive just
> > +	 * after we check the RM3100_REG_STATUS. In this case, irq_handler is
> > +	 * called before measuring_done is reinitialized, it will wait
> > +	 * forever for data that has already been ready.
> > +	 * Reinitialize measuring_done before looking up makes sure we
> > +	 * will always capture interrupt no matter when it happened.
> > +	 */
> > +	if (data->use_interrupt)
> > +		reinit_completion(&data->measuring_done);
> > +

...

> > +static const struct attribute_group rm3100_attribute_group = {
> > +	.attrs = rm3100_attributes,
> > +};
> > +
> > +#define RM3100_SAMP_NUM			14
> 
> Move this to top or .h header file.
> 

I could have move it to the top, but the only related section is
here. It only changes if a new frequency is supported, which seems
not possible from now. Just here to tell the readers how many
frequencies are in the array. So if one day a new frequency is
supported, we can change it easily.

> > +/*
> > + * Frequency : rm3100_samp_rates[][0].rm3100_samp_rates[][1]Hz.
> > + * Time between reading: rm3100_sam_rates[][2]ms.
> > + * The first one is actually 1.7ms.
> > + */
> > +static const int rm3100_samp_rates[RM3100_SAMP_NUM][3] = {
> > +	{600, 0, 2}, {300, 0, 3}, {150, 0, 7}, {75, 0, 13}, {37, 0, 27},
> > +	{18, 0, 55}, {9, 0, 110}, {4, 500000, 220}, {2, 300000, 440},
> > +	{1, 200000, 800}, {0, 600000, 1600}, {0, 300000, 3300},
> > +	{0, 15000, 6700},  {0, 75000, 13000}
> > +};
> > +
> > +static int rm3100_get_samp_freq(struct rm3100_data *data, int *val, int *val2)
> > +{
> > +	int ret;
> > +	int tmp;
> > +
> > +	mutex_lock(&data->lock);
> > +	ret = regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
> 	
> 	use (unsigned int *) throughly as 3rd argument of
> 	regmap_read() everywhere.
> 
> > +	mutex_unlock(&data->lock);
> > +	if (ret < 0)
> > +		return ret;
> > +	*val = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][0];
> > +	*val2 = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][1];
> > +
> > +	return IIO_VAL_INT_PLUS_MICRO;
> > +}
> > +
> > +static int rm3100_set_cycle_count(struct rm3100_data *data, int val)
> > +{
> > +	int ret;
> > +	u8 i;
> > +
> > +	for (i = 0; i < 3; i++) {
> > +		ret = regmap_write(data->regmap, RM3100_REG_CC_X + 2 * i, 100);
> 	
> 	Would be better to use a descriptive macro for 100 instead ?
> 

This was a mistake, my fault.

> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +	if (val == 50)
> > +		data->cycle_count_index = 0;
> > +	else if (val == 100)
> > +		data->cycle_count_index = 1;
> > +	else
> > +		data->cycle_count_index = 2;

...

> > +static const struct regmap_config rm3100_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +
> > +	.rd_table = &rm3100_readable_table,
> > +	.wr_table = &rm3100_writable_table,
> > +	.volatile_table = &rm3100_volatile_table,
> > +
> > +	.cache_type = REGCACHE_RBTREE,
> 
> I wonder when do we use other types of `.cache_type` ?
> 

Interesting question...

> > +static int rm3100_probe(struct i2c_client *client)
> > +{
> > +	struct regmap *regmap;
> > +

...

> > +
> > +#ifndef RM3100_CORE_H
> > +#define RM3100_CORE_H
> > +
> > +#include <linux/regmap.h>
> > +
> > +#define RM3100_REG_REV_ID		0x36
> 
> Does this ID needs to be checked and validated during 
> intialisation with default state ID val ?
> 

No, should remove it.

> > +
> > +/* Cycle Count Registers. */
> > +#define RM3100_REG_CC_X			0x05
> > +#define RM3100_REG_CC_Y			0x07
> > +#define RM3100_REG_CC_Z			0x09
> > +
> > +/* Continues Measurement Mode register. */
> 
> Is it continuous ?
> 
> > +#define RM3100_REG_CMM			0x01
> > +#define RM3100_CMM_START		BIT(0)
> > +#define RM3100_CMM_X			BIT(4)
> > +#define RM3100_CMM_Y			BIT(5)
> > +#define RM3100_CMM_Z			BIT(6)
> > +
> > +/* TiMe Rate Configuration register. */
> 
> Time!
> 
These uppercase letters are explaining why the register is called TMRC,
T(i)M(e) R(ate) C(onfiguration). :)
Though my bad english do carry a lot spell mistakes here...

> > +#define RM3100_REG_TMRC			0x0B
> > +#define RM3100_TMRC_OFFSET		0x92
> > +
> > +/* Result Status register. */
> > +#define RM3100_REG_STATUS		0x34
> > +#define RM3100_STATUS_DRDY		BIT(7)
> 
> If this status bit is a field of status register then
> align this as:
> 
> #define RM3100_REG_STATUS		0x34
> #define	 RM3100_STATUS_DRDY		BIT(7)
> 
> 
> 
> > +/* Measurement result registers. */
> > +#define RM3100_REG_MX2			0x24
> > +#define RM3100_REG_MY2			0x27
> > +#define RM3100_REG_MZ2			0x2a
> > +
> > +#define RM3100_W_REG_START		RM3100_REG_CMM
> > +#define RM3100_W_REG_END		RM3100_REG_REV_ID
> > +#define RM3100_R_REG_START		RM3100_REG_CMM
> > +#define RM3100_R_REG_END		RM3100_REG_STATUS
> > +#define RM3100_V_REG_START		RM3100_REG_MX2
> > +#define RM3100_V_REG_END		RM3100_REG_STATUS
> > +
> > +#define RM3100_SCAN_BYTES		24
> > +
> > +struct rm3100_data {
> > +	struct device *dev;
> 
> Better remove this ?
> 
All applied in the next patch. :)
> 
> -- 
> Himanshu Jha
> Undergraduate Student
> Department of Electronics & Communication
> Guru Tegh Bahadur Institute of Technology

yours,
Song Qiang
