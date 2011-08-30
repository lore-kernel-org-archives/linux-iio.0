Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:52277 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab1H3J4s (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Aug 2011 05:56:48 -0400
Message-ID: <4E5CB5CD.5060301@cam.ac.uk>
Date: Tue, 30 Aug 2011 11:05:01 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Grant Grundler <grundler@google.com>
CC: Dan Carpenter <error27@gmail.com>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: Re: STAGING:iio:light: fix ISL29018 init to handle brownout
References: <20110826011542.GK5975@shale.localdomain> <CANEJEGtys_kBMMPstRahrYq956g22ZgowySxvOCqUpHww6x29w@mail.gmail.com>
In-Reply-To: <CANEJEGtys_kBMMPstRahrYq956g22ZgowySxvOCqUpHww6x29w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/26/11 22:58, Grant Grundler wrote:
> On Thu, Aug 25, 2011 at 6:15 PM, Dan Carpenter <error27@gmail.com> wrote:
> ...
>> In isl29018_write_data() it uses reg (ISL29018_REG_TEST) as the
>> offset into the ->reg_cache[] array:
>>        chip->reg_cache[reg] = regval;
>>
>> But ->reg_cache[] only has 3 elements, so we're past the end of the
>> array.
> 
> Dan,
> I've attached a preliminary patch to fix this that applies on top of
> 176f9f29cec9 "STAGING:iio:light:
> fix ISL29018 init to handle brownout".  This patch applies cleanly to
> the 2.6.38-based chromium.org tree.
> 
> In a nutshell, the attached patch implements what I was thinking of
> last night: don't cache REG_TEST.
> 
> I did change one basic behavior that I think was also broken: cache
> the value regardless of if the transaction completed successfully or
> not. 
Don't do that.  That means userspace will get an invalid value if it reads
in the meantime. If you have an error on a hardware bus - tell userspace about
it and don't 'guess' what is in the register.

Otherwise patch looks fine to me.
>For registers where we are frobbing bits, the later write to the
> same register  might succeed and things will work anyway despite the
> transient failure. If I'm wrong, please comment and I'll repost with
> original behavior.
> 
> I also noticed the original code had an "off-by-one" error in the
> allocation of reg_cache[] (allocated 3 but indexed up to offset +3).
> 
> I'll submit a cleaned up version that should cleanly apply to gregkh's
> staging-2.6 tree.
> 
> thanks again!
> grant

