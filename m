Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38998 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbbKRHe2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Nov 2015 02:34:28 -0500
In-Reply-To: <20151117154716.48f5a2955b2ce4422dcbc763@linux-foundation.org>
References: <1445614411-533-1-git-send-email-daniel.baluta@intel.com> <1445614411-533-2-git-send-email-daniel.baluta@intel.com> <20151110065126.GA20339@lst.de> <20151110131237.894356c2ba17d8e9231509db@linux-foundation.org> <D914B401-E43C-4B55-8224-93CF218FD613@jic23.retrosnub.co.uk> <564860CC.7000206@kernel.org> <20151117154716.48f5a2955b2ce4422dcbc763@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v10 1/5] configfs: Allow dynamic group creation
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Wed, 18 Nov 2015 07:33:57 +0000
To: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>
CC: Christoph Hellwig <hch@lst.de>,
	Daniel Baluta <daniel.baluta@intel.com>, jlbec@evilplan.org,
	linux-iio@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	lars@metafoo.de, knaack.h@gmx.de, linux-kernel@vger.kernel.org,
	octavian.purdila@intel.com, pebolle@tiscali.nl,
	patrick.porlan@intel.com, adriana.reus@intel.com,
	constantin.musca@intel.com, marten@intuitiveaerial.com,
	cristina.opriceana@gmail.com, pmeerw@pmeerw.net,
	viro@zeniv.linux.org.uk
Message-ID: <01253AE7-7798-46ED-B3E4-A2540E577D47@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 17 November 2015 23:47:16 GMT+00:00, Andrew Morton <akpm@linux-foundation.org> wrote:
>On Sun, 15 Nov 2015 10:39:08 +0000 Jonathan Cameron <jic23@kernel.org>
>wrote:
>
>> On 11/11/15 06:43, Jonathan Cameron wrote:
>> > 
>> > 
>> > On 10 November 2015 21:12:37 GMT+00:00, Andrew Morton
><akpm@linux-foundation.org> wrote:
>> >> On Tue, 10 Nov 2015 07:51:26 +0100 Christoph Hellwig <hch@lst.de>
>> >> wrote:
>> >>
>> >>> is this simple addition something you could still send on to
>Linus
>> >>> for this merge window?  I would make my life easier to have it in
>> >>> so I could start using it in patches for various trees in the
>next
>> >>> merge window.
>> >>
>> >> It's super late, but the configfs changes are obviously safe to
>> >> existing code.
>> >>
>> >> What about the IIO changes?  Will someone be merging them for
>4.5-rc1,
>> >> or something else?
>> > Yes. I'll take the IIO bits and ultimately they'll go through Greg
>KH for the 4.5 
>> > merge window.
>> > 
>> Hi Andrew,
>> 
>> Just taken a quick look at your mmotm list and see this ended up in
>the
>> mainline later group (fair enough given the timing!).
>> As such shall we fall back to plan b) a special git branch pulled
>into the trees
>> of anyone who cares?
>> 
>> I'll base such a tree on some obvious point in Linus' tree (either
>4.4 or 4.5-rc1)
>> That way I can get the IIO stuff queued up asap and we can build on
>that going
>> forward during this cycle.
>
>I plan to send configfs-allow-dynamic-group-creation.patch to Linus
>this week.  I'll retain 
>
>iio-core-introduce-iio-configfs-support.patch
>iio-core-introduce-iio-software-triggers.patch
>iio-core-introduce-iio-software-triggers-fix.patch
>iio-trigger-introduce-iio-hrtimer-based-trigger.patch
>iio-documentation-add-iio-configfs-documentation.patch
>
>with a view to dropping them once I see them turn up in linux-next.

That's great. Thanks.

Jonathan

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
