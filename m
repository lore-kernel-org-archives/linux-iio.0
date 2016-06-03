Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33006 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbcFCMTs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 08:19:48 -0400
Subject: Re: [RFC PATCH V2] iio:trigger: Experimental kthread tight loop
 trigger (thread only)
To: Daniel Baluta <daniel.baluta@intel.com>
References: <1457294576-10121-1-git-send-email-jic23@kernel.org>
 <CAEnQRZCQsoXB-D+sJpcN0W1naXzMLq5gp+WYZ51vut7OhM3NCw@mail.gmail.com>
 <1ED0DBE1-293B-4CD5-B429-4FA72E51E9F4@kernel.org>
 <CAEnQRZAgP+=dsXyc8e=ia7gJZ7P_em+ovdwW5U260yfHan+zSg@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d810c18f-65db-8841-61dc-e2314e5403ae@kernel.org>
Date: Fri, 3 Jun 2016 13:19:45 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZAgP+=dsXyc8e=ia7gJZ7P_em+ovdwW5U260yfHan+zSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/06/16 15:59, Daniel Baluta wrote:
> On Tue, May 31, 2016 at 8:44 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>>
>>
>> On 31 May 2016 15:43:54 BST, Daniel Baluta <daniel.baluta@intel.com> wrote:
>>> On Sun, Mar 6, 2016 at 10:02 PM, Jonathan Cameron <jic23@kernel.org>
>>> wrote:
>>>> This patch is in response to that of
>>>> Gregor Boirie <gregor.boirie@parrot.com>
>>>> who proposed using a tight kthread within a device driver (be it with
>>> the
>>>> support factored out into a helper library) in order to basically
>>> spin as
>>>> fast as possible.
>>>>
>>>> It is meant as a talking point rather than a formal proposal of the
>>> code
>>>> (though we are heading towards that I think).
>>>> Also gives people some working code to mess around with.
>>>>
>>>> I proposed that this could be done with a trigger with a few
>>> constraints
>>>> and this is the proof (be it ugly) of that.
>>>>
>>>> There are some constraints though, some of which we would want to
>>> relax
>>>> if this were to move forward.
>>>>
>>>> * Will only run the thread part of the registered pollfunc.  This is
>>> to
>>>>   avoid the overhead of jumping in and out of interrupt context.  Is
>>> the
>>>>   overhead significant?  Not certain but feels like it should be!
>>>>
>>>> * This limitation precludes any device that 'must' do some work in
>>>>   interrupt context.  However, that is true of few if any drivers and
>>>>   I suspect that any that do will be restricted to using triggers
>>> they
>>>>   provide themselves.  Usually we have a top half mainly to grab a
>>>>   timestamp as soon after the dataready type signal as possible.
>>>>
>>>
>>> Configfs part looks good to me.
>>>
>>> What happens with iio_loop_thread when changing the current trigger?
>>> I'm not sure how it will be stopped.
>>
>> To change trigger the buffer will be disabled ultimately calling the state
>>  function with false. That calls kthread_stop and the loop should drop
>>  out with the tread exiting.
> 
> This makes sense. I missed the disable buffer thing.
> 
> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
Thanks,

Applied to the togreg branch of iio.git.
> 
> We shouldn't forget about updating Documentation:
> http://lxr.free-electrons.com/source/Documentation/iio/iio_configfs.txt#L75
> 
> I should do the same for software IIO devices.
> 
Good point - please kick me if I don't get to the is sometime in the next week or two.

Jonathan
> Daniel.
> 

