Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58444 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbbIUTry (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Sep 2015 15:47:54 -0400
Subject: Re: [PATCH] Asus T300CHI.
To: Bastien Nocera <hadess@hadess.net>,
	Mike Mestnik <cheako@mikemestnik.net>,
	Daniel Baluta <daniel.baluta@gmail.com>
References: <CAF8px547WhBsfmV8K8OLbqTbADWbu0sD1jUjrGEPHVZfEzrP6w@mail.gmail.com>
 <CAEnQRZAX1=Y4SaOrpfbWRLR1kYmNKJjeKKouS6pkeb2BBDzr-g@mail.gmail.com>
 <CAF8px56ehuZxcP9EJ3d+M68CdYJKdkiaRs_g1+S8euiFKA5pkA@mail.gmail.com>
 <55FF0433.6050900@kernel.org> <1442788960.1030.11.camel@hadess.net>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56005EE8.40805@kernel.org>
Date: Mon, 21 Sep 2015 20:47:52 +0100
MIME-Version: 1.0
In-Reply-To: <1442788960.1030.11.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/09/15 23:42, Bastien Nocera wrote:
> On Sun, 2015-09-20 at 20:08 +0100, Jonathan Cameron wrote:
>> On 19/09/15 20:03, Mike Mestnik wrote:
>>> On Sat, Sep 19, 2015 at 1:48 PM, Daniel Baluta <
>>> daniel.baluta@gmail.com> wrote:
>>>> On Fri, Sep 18, 2015 at 12:07 AM, Mike Mestnik <
>>>> cheako@mikemestnik.net> wrote:
>>>>> Hello,
>>>>>   I'm looking to know the result of adding ACPI support for a
>>>>> new
>>>>> tablet, the existing support shouldn't work because of a
>>>>> misplaced
>>>>> __init that causes the function to be removed prior to being
>>>>> called.
>>>>
>>>> Are you sure about this? It seems that the existing support
>>>> doesn't work
>>>> because you have different product ids.
>>>>
>>> The driver worked much better prior to me adding the product ids. 
>>>  The
>>> sensors were exposed to sysfs and all the data they collected
>>> seemed
>>> correct to me.  The big issue is that there is no software, even
>>> iio-sensor-proxy didn't know how to access the data.
>> Cc'd Bastien Nocera.
> 
> iio-sensor-proxy not finding the sensor, and with it working otherwise,
> would be an iio-sensor-proxy bug. I have one of those already for the
> accelerometer in the WinBook TW100 that I haven't had time to root down
> though. See:
> https://github.com/hadess/iio-sensor-proxy/issues/39
> 
> The main problem being that sensor types are already hard to detect,
> and the iio subsystem doesn't make it any easier to check whether
> there's buffered output available, or the application needs to poll.
> 
> If anyone wants to fix that in the kernel, that would certainly make my
> life easier.
> 
Suggestions for improvements welcome, but take into account that I for
one am unconvinced that a bit of parsing for presence of files is 
bad enough to demand another ABI to read them same things.

Jonathan
> Cheers
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

