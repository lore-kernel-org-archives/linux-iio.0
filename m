Return-Path: <jic23@cam.ac.uk>
References: <1339367961-22456-1-git-send-email-pmeerw@pmeerw.net> <4FD635A0.7050507@kernel.org> <alpine.DEB.2.01.1206112328220.30702@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1206112328220.30702@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: iio: vcnl4000 ALS/proximity driver
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 12 Jun 2012 06:49:11 +0100
To: Peter Meerwald <pmeerw@pmeerw.net>,Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Message-ID: <3a7abb16-df44-4b5b-9651-d0399659c4af@email.android.com>
List-ID: <linux-iio@vger.kernel.org>



Peter Meerwald <pmeerw@pmeerw.net> wrote:

>Hello Jonathan,
>
>> > I am l=
ost with the meaning and use of IIO modifiers...
>> Quick and dirty summary=
.
>> Calibscale is internally applied within the hardware (or occasionally
=
>> software but looks like it was in the hardware from point of view
>> of =
userspace!)
>
>thank you for clarification
>
>Am I missing documentation so=
mewhere?
>
Documentation/ABI/testing/sysfs-bus-iio.

>
>some comments in ii=
o/types.h iio/iio.h would avoid guesswork...
>
>enum iio_chan_type {
>	/* r=
eal channel types */	
>are there unreal channels also? :)
>
>what is IIO_AN=
GL_VEL vs. IIO_ANGL? VOLTAGE vs. ALTVOLTAGE?
>
>what is LIGHT_BOTH?
>
>it w=
ould be helpful what IIO_CHAN_INFO_SHARED_BIT vs 
>IIO_CHAN_INFO_SEPARATE_B=
IT relates to?
>
>IIO_CHAN_INFO_SAMP_FREQ vs IIO_CHAN_INFO_FREQUENCY?
>
>th=
anks, regards, p.
>
>-- 
>
>Peter Meerwald
>+43-664-2444418 (mobile)
>--
>T=
o unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the=
 body of a message to majordomo@vger.kernel.org
>More majordomo info at  ht=
tp://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone wi=
th K-9 Mail. Please excuse my brevity.
