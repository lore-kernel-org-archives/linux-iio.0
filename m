Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51396 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755449AbaIQQVw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Sep 2014 12:21:52 -0400
In-Reply-To: <20140917150041.GA6903@saruman.home>
References: <1409671066-25747-1-git-send-email-balbi@ti.com> <54147632.9090204@kernel.org> <20140915052137.GA11866@saruman.home> <20140916170316.GD19010@saruman.home> <20140917150041.GA6903@saruman.home>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [RESEND PATCH] iio: light: add support for TI's opt3001 light sensor
From: Jonathan Cameron <jic23@kernel.org>
Date: Wed, 17 Sep 2014 17:21:10 +0100
To: balbi@ti.com
CC: linux-iio@vger.kernel.org, pmeerw@pmeerw.net,
	Andrew Morton <akpm@linux-foundation.org>
Message-ID: <1c0e34c9-0bbf-4df4-885c-d7190b29cc3f@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I'm confused. Are you not receiving my emails?

On September 17, 2014 4:00:41 PM GMT+01:00, Felipe Balbi <balbi@ti.com> wrote:
>ping
>
>On Tue, Sep 16, 2014 at 12:03:16PM -0500, Felipe Balbi wrote:
>> ping
>> 
>> On Mon, Sep 15, 2014 at 12:21:37AM -0500, Felipe Balbi wrote:
>> > Hi,
>> > 
>> > On Sat, Sep 13, 2014 at 05:52:02PM +0100, Jonathan Cameron wrote:
>> > > On 02/09/14 16:17, Felipe Balbi wrote:
>> > > > TI's opt3001 light sensor is a simple and yet powerful
>> > > > little device. The device provides 99% IR rejection,
>> > > > Automatic full-scale, very low power consumption and
>> > > > measurements from 0.01 to 83k lux.
>> > > > 
>> > > > This patch adds support for that device using the IIO
>> > > > framework.
>> > > > 
>> > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
>> > > > ---
>> > > > 
>> > > > Resending as I saw no changes on the thread.
>> > > Hi Felipe,
>> > > 
>> > > Sorry for the delay on this, entirely my fault - been busy and
>forgot
>> > > I still had questions about what was going on in here (yup its
>the
>> > > hysteresis bit again!)
>> > 
>> > right, this is starting to become way too much headache for such a
>> > simple device. Sorry will not help me getting this driver upstream.
>When
>> > I first sent this (August 6), we didn't even have v3.17-rc1, now
>we're
>> > about to tag -rc5 and I'm worried this driver will not hit v3.18
>merge
>> > window.
>> > 
>> > > Anyhow, I'm afraid I am still a little confused about the meaning
>you
>> > > have assigned to Hysteresis in this driver.
>> > > 
>> > > Let me conjecture on what might be going on here (I may be
>entirely
>> > > wrong).
>> > > 
>> > > Normally a hysteresis value in IIO is defined as the 'distance'
>back
>> > > from a threshold that a signal must go before it may retrip the
>> > > threshold.
>> > > This threshold value is separately controlled. Thus if we have a
>> > > rising threshold of 10 and an hysteresis of 2 - to get two events
>the
>> > > signal must first rise past 10, then drop back below 8 and rise
>again
>> > > past 10.
>> > > If it drops below 10 but not 8 and rises again past 10 then we
>will
>> > > not get an event.
>> > > 
>> > > So having the same register for both the hysteresis and the
>threshold
>> > > doesn't with this description make much sense.  It would mean
>that you
>> > > could only have a threshold of say 10 and a hysteresis of 10,
>thus in
>> > > effect meaning the signal would always have to cross 0 before the
>next
>> > > event whatever the combined threshold / hysteresis value?
>> > > 
>> > > Perhaps instead the device is automatically adjusting the
>threshold
>> > > when we cross it and the 'hysteresis' here is with respect to a
>the
>> > > previous threshold?
>> > > 
>> > > Thus if we start with a value of 0 and hysteresis is set to 2 it
>will
>> > > trigger an event at:
>> > > 
>> > > 2, 4, 6, 8, 10 as we rise?
>> > > 
>> > > This sort of auto adjustment of levels isn't uncommon in light
>sensors
>> > > (where the point of the interrupt is to notify the operating
>system
>> > > that a 'significant' change has occurred and things like screen
>> > > brightness may need adjusting.
>> > > 
>> > > If so then the current hysteresis interface does not apply, nor
>does
>> > > the Rate of Change (ROC) interface as this is dependent on amount
>of
>> > > change, not how fast it changed.  Hence we needs something new to
>> > > handle this cleanly. I would suggest a new event type.  Perhaps
>> > > something with sysfs attr naming along the lines of
>> > > What:		/sys/.../iio:deviceX/events/in_light_change_rising_en
>> > > What:          
>/sys/.../iio:deviceX/events/in_light_change_rising_value
>> > > 
>> > > etc?
>> > 
>> > will you just tell me what you want ? I really cannot give a crap
>> > anymore. This has already taken me over a month of my time for such
>a
>> > simple little device, not to mention your confusing and
>contradicting
>> > change requests.
>> > 
>> > (could you also trim your responses ? it's very annoying to scroll
>so
>> > much)
>> > 
>> > > > +#define OPT3001_RESULT		0x00
>> > > > +#define OPT3001_CONFIGURATION	0x01
>> > > > +#define OPT3001_LOW_LIMIT	0x02
>> > > > +#define OPT3001_HIGH_LIMIT	0x03
>> > > > +#define OPT3001_MANUFACTURER_ID	0x7e
>> > > > +#define OPT3001_DEVICE_ID	0x7f
>> > > > +
>> > > > +#define OPT3001_CONFIGURATION_RN_MASK (0xf << 12)
>> > > > +#define OPT3001_CONFIGURATION_RN_AUTO (0xc << 12)
>> > > > +
>> > > > +#define OPT3001_CONFIGURATION_CT	BIT(11)
>> > > > +
>> > > > +#define OPT3001_CONFIGURATION_M_MASK	(3 << 9)
>> > > > +#define OPT3001_CONFIGURATION_M_SHUTDOWN (0 << 9)
>> > > > +#define OPT3001_CONFIGURATION_M_SINGLE (1 << 9)
>> > > > +#define OPT3001_CONFIGURATION_M_CONTINUOUS (2 << 9) /* also 3
><< 9 */
>> > > > +
>> > > 
>> > > I guess this naming is straight off the datasheet, but it is
>rather
>> > > more cryptic than perhaps it needs to be!  That's kind of an
>issue
>> > > with the datasheet choices rather than what you have here
>however!
>> > 
>> > man, are you nit-picky!! These are named as such to make grepping
>on
>> > documentation easier. It's better to have something that matches
>> > documentation, don't you think ? otherwise, future users/developers
>of
>> > these driver will need either a shit ton of comments explaining
>that A
>> > maps to B in docs, or will need a fscking crystal ball to read my
>mind.
>> > Assuming I'll still remember what I meant.
>> > 
>> > > > +static int opt3001_remove(struct i2c_client *client)
>> > > > +{
>> > > > +	struct iio_dev *iio = i2c_get_clientdata(client);
>> > > > +	struct opt3001 *opt = iio_priv(iio);
>> > > > +	int ret;
>> > > > +	u16 reg;
>> > > > +
>> > > > +	free_irq(client->irq, iio);
>> > > > +	iio_device_unregister(iio);
>> > > > +
>> > > > +	ret = i2c_smbus_read_word_swapped(opt->client,
>OPT3001_CONFIGURATION);
>> > > > +	if (ret < 0) {
>> > > > +		dev_err(opt->dev, "failed to read register %02x\n",
>> > > > +				OPT3001_CONFIGURATION);
>> > > > +		return ret;
>> > > > +	}
>> > > > +
>> > > > +	reg = ret;
>> > > > +	opt3001_set_mode(opt, &reg,
>OPT3001_CONFIGURATION_M_SHUTDOWN);
>> > > > +
>> > > > +	ret = i2c_smbus_write_word_swapped(opt->client,
>OPT3001_CONFIGURATION,
>> > > > +			reg);
>> > > > +	if (ret < 0) {
>> > > > +		dev_err(opt->dev, "failed to write register %02x\n",
>> > > > +				OPT3001_CONFIGURATION);
>> > > > +		return ret;
>> > > > +	}
>> > > > +
>> > > > +	iio_device_free(iio);
>> > >
>> > > Use the devm_iio_device_alloc and you can drop the need to free
>it.
>> > > I don't really mind, but I'll almost guarantee that someone will
>post
>> > > a follow up patch doing this if you don't.  As it will be ever so
>> > > slightly cleaner, I'll probably take that patch.
>> > 
>> > here's the original driver:
>> > 
>> > http://www.spinics.net/lists/linux-iio/msg14331.html
>> > 
>> > notice that it *WAS* *USING* devm_iio_device_alloc(), until:
>> > 
>> > http://www.spinics.net/lists/linux-iio/msg14421.html
>> > 
>> > you *SPECIFICALLY* asked for *NON* *DEVM* versions!!
>> > 
>> > So figure out what you really want, let me know and I'll code it
>all up
>> > quickly and hopefully still get this into v3.18 merge window. I
>sent
>> > this driver *very* early to be doubly sure it would hit v3.18 and
>there
>> > was a long hiatus from yourself which is now jeopardizing what I
>was
>> > expecting. That, coupled with your contradicting requests, has just
>put
>> > me in a bad mood, even before Monday, hurray.
>> > 
>> > cheers
>> > 
>> > -- 
>> > balbi
>> 
>> 
>> 
>> -- 
>> balbi

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
