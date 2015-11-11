Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36132 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbKKGnw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Nov 2015 01:43:52 -0500
In-Reply-To: <20151110131237.894356c2ba17d8e9231509db@linux-foundation.org>
References: <1445614411-533-1-git-send-email-daniel.baluta@intel.com> <1445614411-533-2-git-send-email-daniel.baluta@intel.com> <20151110065126.GA20339@lst.de> <20151110131237.894356c2ba17d8e9231509db@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v10 1/5] configfs: Allow dynamic group creation
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Wed, 11 Nov 2015 06:43:43 +0000
To: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
CC: Daniel Baluta <daniel.baluta@intel.com>, jic23@kernel.org,
	jlbec@evilplan.org, linux-iio@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de,
	linux-kernel@vger.kernel.org, octavian.purdila@intel.com,
	pebolle@tiscali.nl, patrick.porlan@intel.com,
	adriana.reus@intel.com, constantin.musca@intel.com,
	marten@intuitiveaerial.com, cristina.opriceana@gmail.com,
	pmeerw@pmeerw.net, viro@zeniv.linux.org.uk
Message-ID: <D914B401-E43C-4B55-8224-93CF218FD613@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 10 November 2015 21:12:37 GMT+00:00, Andrew Morton <akpm@linux-foundation.org> wrote:
>On Tue, 10 Nov 2015 07:51:26 +0100 Christoph Hellwig <hch@lst.de>
>wrote:
>
>> is this simple addition something you could still send on to Linus
>> for this merge window?  I would make my life easier to have it in
>> so I could start using it in patches for various trees in the next
>> merge window.
>
>It's super late, but the configfs changes are obviously safe to
>existing code.
>
>What about the IIO changes?  Will someone be merging them for 4.5-rc1,
>or something else?
Yes. I'll take the IIO bits and ultimately they'll go through Greg KH for the 4.5 
merge window.

Jonathan
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
