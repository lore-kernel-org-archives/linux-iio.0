Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55130 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbaDZKuX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 26 Apr 2014 06:50:23 -0400
Message-ID: <535B8FC7.7010308@kernel.org>
Date: Sat, 26 Apr 2014 11:51:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/6] iio: st_sensors: announce registered sensors
References: <1397416143-4396-1-git-send-email-linus.walleij@linaro.org>	<1397416143-4396-2-git-send-email-linus.walleij@linaro.org>	<53582EF3.2040307@kernel.org> <CACRpkda1tZNF6gGo+HMaYmKnzuRHBMz6PRVeN+K5m8JessOrqw@mail.gmail.com>
In-Reply-To: <CACRpkda1tZNF6gGo+HMaYmKnzuRHBMz6PRVeN+K5m8JessOrqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/04/14 09:30, Linus Walleij wrote:
> On Wed, Apr 23, 2014 at 11:21 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 13/04/14 20:08, Linus Walleij wrote:
>>>
>>> It is pretty helpful to know already from dmesg that a certain
>>> device is successfully registered, instead of having to browse
>>> sysfs to see if it's actually there.
>>>
>>> Cc: Lee Jones <lee.jones@linaro.org>
>>> Cc: Denis CIOCCA <denis.ciocca@st.com>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>>
>> hmm.. Normally I get irritated with these sorts of I'm here
>> messages - it's not exactly hard to tell it has been successfully
>> probed without filling the logs with messages fairly light on
>> info.  Having said that I tend to let these go in new drivers
>> so I don't care that strongly...
>
> Your pick, this patch is orthogonal to the rest.
>
> I tend to stick a oneliner at the end of successful probe
> to verify that the device driver has been compiled in and
> that it probes correctly so that the device tree etc is in
> order. Of course there are other ways to determine that
> but the dmesg give it all in one place for all devices.
>
Fair enough I suppose. Applied to the togreg branch of iio.git.
Will initially be pushed out as testing for the autobuilders
to play around with it.


