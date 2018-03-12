Return-Path: <SRS0=EEFn=GC=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Mon, 12 Mar 2018 09:25:01 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Graff Yang <graff.yang@gmail.com>, daniel.baluta@nxp.com,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] staging:iio:ad2s1210: Add comments/documentation
Message-ID: <20180312122501.uvi7vehghf3h5ha5@smtp.gmail.com>
References: <cover.1520638889.git.rodrigosiqueiramelo@gmail.com>
 <813ae9b3a8d6d9b0e6d4d4b6dda7fe354375fc8d.1520638889.git.rodrigosiqueiramelo@gmail.com>
 <20180310175246.7e591c11@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180310175246.7e591c11@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On 03/10, Jonathan Cameron wrote:
> On Fri, 9 Mar 2018 20:46:40 -0300
> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
> 
> > The original code of AD2S1210 does not have documentation for structs
> > and register configurations; this difficult the code comprehension. This
> > patch adds structs documentation, briefly comments some register
> > settings and acronyms, and adds little explanations of some calculation
> > found in the code.
> > 
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Various comments inline.
> 
> Only a few of them are about you actual patch - mostly more general.
> 
> I'd look at renaming all those defines to be more consistent.  There
> is no association between bits of a register and the register at the
> moment which will make the code rather error prone.
> 
> Note this is going to be a difficult driver to get out of staging.
> There is quite a bit to do and we don't currently have anyone who
> has test hardware as far as I know.  So brave move ;)

Hi Jonathan,

After careful reading your email, I believe that is a better idea to
divide this kind of work in other patches. So, instead of trying to
document the module at once, I will do it step by step in the future
patches series; I take note of all your comments. I will put an effort
in this module because I think that is an excellent opportunity to learn
the IIO subsystem. Finally, I will try to contact Analog Devices; maybe
someone can test the module for me.

Thanks for all the reviews and comments, I learned a lot with all your
explanations :)
 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/staging/iio/resolver/ad2s1210.c | 32 ++++++++++++++++++++++++++++++++
> >  drivers/staging/iio/resolver/ad2s1210.h |  9 ++++++++-
> >  2 files changed, 40 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> > index ac13b99bd9cb..9bb8fd782f5a 100644
> > --- a/drivers/staging/iio/resolver/ad2s1210.c
> > +++ b/drivers/staging/iio/resolver/ad2s1210.c
> > @@ -24,8 +24,10 @@
> >  
> >  #define DRV_NAME "ad2s1210"
> >  
> > +/* The default value of the control register on power-up */
> >  #define AD2S1210_DEF_CONTROL		0x7E
> >  
> > +/* Control Register Bit */
> I would change the defines to make this explicit.
> This is a truely odd bit of naming anyway.
> #define AD2S1210_ADDRESS 0x80
> #define AD2S1210_DATA 0x00 
> and perhaps a
> #define AD2S1210_DATA_MASK 0x7F
> 
> would make sense?
> 
> 
> >  #define AD2S1210_MSB_IS_HIGH		0x80
> >  #define AD2S1210_MSB_IS_LOW		0x7F
> >  #define AD2S1210_PHASE_LOCK_RANGE_44	0x20
> > @@ -39,14 +41,23 @@
> >  
> >  #define AD2S1210_REG_POSITION		0x80
> >  #define AD2S1210_REG_VELOCITY		0x82
> > +
> > +/* Loss of Signal (LOS) register address */
> >  #define AD2S1210_REG_LOS_THRD		0x88
> > +
> > +/* Degradation of Signal (DOS) register address */
> addresses
> 
> >  #define AD2S1210_REG_DOS_OVR_THRD	0x89
> >  #define AD2S1210_REG_DOS_MIS_THRD	0x8A
> >  #define AD2S1210_REG_DOS_RST_MAX_THRD	0x8B
> >  #define AD2S1210_REG_DOS_RST_MIN_THRD	0x8C
> > +
> > +/* Loss of Tracking (LOT) register address */
> addresses 
> 
> >  #define AD2S1210_REG_LOT_HIGH_THRD	0x8D
> >  #define AD2S1210_REG_LOT_LOW_THRD	0x8E
> > +
> > +/* Excitation Frequency (EXCIT) register address */
> >  #define AD2S1210_REG_EXCIT_FREQ		0x91
> > +
> >  #define AD2S1210_REG_CONTROL		0x92
> >  #define AD2S1210_REG_SOFT_RESET		0xF0
> >  #define AD2S1210_REG_FAULT		0xFF
> > @@ -69,6 +80,20 @@ enum ad2s1210_mode {
> >  
> >  static const unsigned int ad2s1210_resolution_value[] = { 10, 12, 14, 16 };
> >  
> > +/**
> > + * struct ad2s1210_state - device instance specific state.
> > + * @pdata:		chip model specific constants, gpioin, etc
> Except they aren't anything to do with the chip model.  This is about
> how it is wired not what it is. 
> 
> > + * @lock:		lock to ensure state is consistent
> > + * @sdev:		the SPI device for this driver instance
> > + * @fclkin:		frequency of clock input
> > + * @fexcit:		excitation frequency
> > + * @hysteresis:		cache of whether hysteresis is enabled
> > + * @old_data:		cache of SPI communication after operation
> Umm. You got rid of this one in the earlier patch didn't you?
> 
> > + * @resolution:		chip resolution could be 10/12/14/16-bit
> From reading the datasheet quickly I suspect there is a 'best possible'
> resolution given a particular set of controls.  I'm not sure we want
> to expose this to userspace at all.
> 
> > + * @mode:		indicates the operating mode
> Where operating mode is what? Comment would be more useful if it
> listed them.
> 
> > + * @rx:			receive buffer
> > + * @tx:			transmit buffer
> > + */
> >  struct ad2s1210_state {
> >  	const struct ad2s1210_platform_data *pdata;
> >  	struct mutex lock;
> > @@ -82,6 +107,7 @@ struct ad2s1210_state {
> >  	u8 tx[2] ____cacheline_aligned;
> >  };
> >  
> > +/* Maps A0 and A1 inputs to the respective mode.  */
> >  static const int ad2s1210_mode_vals[4][2] = {
> >  	[MOD_POS] = { 0, 0 },
> >  	[MOD_VEL] = { 0, 1 },
> > @@ -137,6 +163,11 @@ int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
> >  	int ret;
> >  	unsigned char fcw;
> >  
> > +	/*
> > +	 * The fcw stands for frequency control word, which can be obtained
> > +	 * from:
> > +	 * fcw = (Excitation Frequency * 2^15) / fclkin
> > +	 */
> Whilst we are here - userspace being responsible for writing a hardware
> frequency input needs to change.  Makes no sense.
> 
> >  	fcw = (unsigned char)(st->fexcit * (1 << 15) / st->fclkin);
> >  	if (fcw < AD2S1210_MIN_FCW || fcw > AD2S1210_MAX_FCW) {
> >  		dev_err(&st->sdev->dev, "ad2s1210: FCW out of range\n");
> > @@ -158,6 +189,7 @@ static unsigned char ad2s1210_read_resolution_pin(struct ad2s1210_state *st)
> >  	return ad2s1210_resolution_value[resolution];
> >  }
> >  
> > +/* Maps RES0 and RES1 inputs to the respective mode.  */
> >  static const int ad2s1210_res_pins[4][2] = {
> >  	{ 0, 0 }, {0, 1}, {1, 0}, {1, 1}
> >  };
> > diff --git a/drivers/staging/iio/resolver/ad2s1210.h b/drivers/staging/iio/resolver/ad2s1210.h
> > index e9b2147701fc..cbe21bca7638 100644
> > --- a/drivers/staging/iio/resolver/ad2s1210.h
> > +++ b/drivers/staging/iio/resolver/ad2s1210.h
> > @@ -1,5 +1,5 @@
> >  /*
> > - * ad2s1210.h plaform data for the ADI Resolver to Digital Converters:
> > + * ad2s1210.h platform data for the ADI Resolver to Digital Converters:
> >   * AD2S1210
> Hmm. I would suggest that, seeing as we don't have any in kernel users
> we should probably just drop the platform data in favour of a devicetree
> binding.
> 
> Fair enough to document it as an intermediate step however.
> >   *
> >   * Copyright (c) 2010-2010 Analog Devices Inc.
> > @@ -11,6 +11,13 @@
> >  #ifndef _AD2S1210_H
> >  #define _AD2S1210_H
> >  
> > +/**
> > + * struct ad2s1210_platform_data - chip model
> > + * @sample:	sample input used to clearing the fault register
> This hasn't been a good means of proving a gpio for some time.
> These all want converting over to the current gpio handling best practice.
> 
> > + * @a:		array of inputs (A0 and A1)
> > + * @res:	array of resolution inputs (RES0 and RES1)
> > + * @gpioin:	control the read operation
> In what way?  I think this is actually a hack to allow for the
> fact that the above pins may not be controllable by the driver.
> Not sure though as I haven't chased through the code fully.
> 
> > + */
> >  struct ad2s1210_platform_data {
> >  	unsigned int		sample;
> >  	unsigned int		a[2];
> 
