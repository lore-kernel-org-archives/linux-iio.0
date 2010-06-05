Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20100604152806.GB25400@suse.de>
References: <1275643194-25328-1-git-send-email-21cnbao@gmail.com>
	<1275643194-25328-2-git-send-email-21cnbao@gmail.com> <4C08DBC5.1040206@cam.ac.uk>
	<20100604152806.GB25400@suse.de>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 5 Jun 2010 08:43:54 +0800
Message-ID: <AANLkTikgTIx_Yoh5nlHY75InQpOV4BLuy2yF5SJMBExv@mail.gmail.com>
Subject: Re: [PATCH 1/3] adis16300: fix some minor issues and clean-up
To: Greg KH <gregkh@suse.de>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 4, 2010 at 11:28 PM, Greg KH <gregkh@suse.de> wrote:
> On Fri, Jun 04, 2010 at 11:56:05AM +0100, Jonathan Cameron wrote:
>> On 06/04/10 10:19, Barry Song wrote:
>> > 1. add delay between spi transfers
>> > 2. move burst read to ring function
>> > 3. clean-up
>> I think I'm right in saying that, this lot will appear in the commit message.
>> Comments like this should go below.
>
> Yes, and that's good, it should be in the commit message, right?
Yes. it should be in the commit message, then people know the details
about this commit.
>
> thanks,
>
> greg k-h
>
