Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33261 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965516AbcBQVpV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Feb 2016 16:45:21 -0500
Received: by mail-lf0-f46.google.com with SMTP id m1so20287094lfg.0
        for <linux-iio@vger.kernel.org>; Wed, 17 Feb 2016 13:45:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56C4E3E2.8040505@kernel.org>
References: <1455412842-750-1-git-send-email-mranostay@gmail.com>
 <56C096F3.9070908@kernel.org> <56C0BBFF.5040703@metafoo.de>
 <20160215150242.GM18988@sirena.org.uk> <56C4E3E2.8040505@kernel.org>
From: Matt Ranostay <mranostay@gmail.com>
Date: Wed, 17 Feb 2016 13:44:40 -0800
Message-ID: <CAKzfze8VfMrv4rKXthZAT_JgcOazDpXTLvvsuJpQA8q553y-xA@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: atlas-ph-sensor: switch regmap cache
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Feb 17, 2016 at 1:19 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 15/02/16 15:02, Mark Brown wrote:
>> On Sun, Feb 14, 2016 at 06:40:15PM +0100, Lars-Peter Clausen wrote:
>>> On 02/14/2016 04:02 PM, Jonathan Cameron wrote:
>>
>>>> I'm lost here. Why should changing the storage of the register cache result
>>>> in different behaviour other than in efficiency of access to cached values?
>>
>>> And if there is really a difference this should probably be addressed at the
>>> regmap level.
>>
>> You'd need to make regcache-flat keep track of which cache values are
>> valid either during init (in which case it'd have to read every other
>> register at that time) or at runtime (which would mean extra operations
>> in a fast path).  Flat really is special here, there's no reason to use
>> it over a rbtree other than being very sensitive about performance.
>>
>> Please also be aware that if you CC me on an iio patch series there's a
>> good chance I'll just delete it without reading it, for some reason I
>> keep on getting copied on lots of them which have no relevance to me
>> that I'm able to identify.
>>
> Hmm.  Not the best documented 'non intuitive case' ever, but fair enough.
> Glad you did pick this one up Mark!
>
> So Matt, the reason those two elements are dropped from being volatile
> is that they never were, but because we were using a flat cache it wasn't
> getting the original values?
>
> If so fair enough I suppose, but please confirm that I've understood this
> correctly + I'll probably expand the patch description somewhat to make it
> clearer why the original was wrong.

That is correct. Flat cache wasn't getting the on device value without
it being set as volatile.


>
> Jonathan
