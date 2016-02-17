Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56553 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423662AbcBQVTd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Feb 2016 16:19:33 -0500
Subject: Re: [PATCH] iio: chemical: atlas-ph-sensor: switch regmap cache
To: Mark Brown <broonie@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
References: <1455412842-750-1-git-send-email-mranostay@gmail.com>
 <56C096F3.9070908@kernel.org> <56C0BBFF.5040703@metafoo.de>
 <20160215150242.GM18988@sirena.org.uk>
Cc: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56C4E3E2.8040505@kernel.org>
Date: Wed, 17 Feb 2016 21:19:30 +0000
MIME-Version: 1.0
In-Reply-To: <20160215150242.GM18988@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/02/16 15:02, Mark Brown wrote:
> On Sun, Feb 14, 2016 at 06:40:15PM +0100, Lars-Peter Clausen wrote:
>> On 02/14/2016 04:02 PM, Jonathan Cameron wrote:
> 
>>> I'm lost here. Why should changing the storage of the register cache result
>>> in different behaviour other than in efficiency of access to cached values?
> 
>> And if there is really a difference this should probably be addressed at the
>> regmap level.
> 
> You'd need to make regcache-flat keep track of which cache values are
> valid either during init (in which case it'd have to read every other
> register at that time) or at runtime (which would mean extra operations
> in a fast path).  Flat really is special here, there's no reason to use
> it over a rbtree other than being very sensitive about performance.
> 
> Please also be aware that if you CC me on an iio patch series there's a
> good chance I'll just delete it without reading it, for some reason I
> keep on getting copied on lots of them which have no relevance to me
> that I'm able to identify.
> 
Hmm.  Not the best documented 'non intuitive case' ever, but fair enough.
Glad you did pick this one up Mark!

So Matt, the reason those two elements are dropped from being volatile
is that they never were, but because we were using a flat cache it wasn't
getting the original values?

If so fair enough I suppose, but please confirm that I've understood this
correctly + I'll probably expand the patch description somewhat to make it
clearer why the original was wrong.

Jonathan
