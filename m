Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35462 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbbKJVMi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Nov 2015 16:12:38 -0500
Date: Tue, 10 Nov 2015 13:12:37 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Baluta <daniel.baluta@intel.com>, jic23@kernel.org,
	jlbec@evilplan.org, linux-iio@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de,
	linux-kernel@vger.kernel.org, octavian.purdila@intel.com,
	pebolle@tiscali.nl, patrick.porlan@intel.com,
	adriana.reus@intel.com, constantin.musca@intel.com,
	marten@intuitiveaerial.com, cristina.opriceana@gmail.com,
	pmeerw@pmeerw.net, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v10 1/5] configfs: Allow dynamic group creation
Message-Id: <20151110131237.894356c2ba17d8e9231509db@linux-foundation.org>
In-Reply-To: <20151110065126.GA20339@lst.de>
References: <1445614411-533-1-git-send-email-daniel.baluta@intel.com>
	<1445614411-533-2-git-send-email-daniel.baluta@intel.com>
	<20151110065126.GA20339@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 10 Nov 2015 07:51:26 +0100 Christoph Hellwig <hch@lst.de> wrote:

> is this simple addition something you could still send on to Linus
> for this merge window?  I would make my life easier to have it in
> so I could start using it in patches for various trees in the next
> merge window.

It's super late, but the configfs changes are obviously safe to
existing code.

What about the IIO changes?  Will someone be merging them for 4.5-rc1,
or something else?

