Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36192 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032020AbbKFJBl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 6 Nov 2015 04:01:41 -0500
MIME-Version: 1.0
In-Reply-To: <20151106075008.GA30535@lst.de>
References: <1445614411-533-1-git-send-email-daniel.baluta@intel.com>
	<1445614411-533-2-git-send-email-daniel.baluta@intel.com>
	<20151106075008.GA30535@lst.de>
Date: Fri, 6 Nov 2015 10:48:48 +0200
Message-ID: <CAEnQRZBjy3jnNFA77nrY+3h93MsEqGMko4cicqMP-RHBhLx0UQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] configfs: Allow dynamic group creation
From: Daniel Baluta <daniel.baluta@intel.com>
To: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Joel Becker <jlbec@evilplan.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>, patrick.porlan@intel.com,
	Adriana Reus <adriana.reus@intel.com>,
	constantin.musca@intel.com, marten@intuitiveaerial.com,
	Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Nov 6, 2015 at 9:50 AM, Christoph Hellwig <hch@lst.de> wrote:
> Is this going into 4.4 through the iio tree?  If not is there any chance
> to get it in through some other tree?  While we're not past the merge
> window is trivial new functionality that doesn't change code, and I'd like to
> move existing configfs users over to it ASAP, so getting it into a baseline
> tree ASAP would be immensely helpful.

I think Jonathan could take this via linux-iio around Sunday.

Could anyone do it faster :)? Andrew?

>
> Oh, and:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

I didn't add your Reviewed-by tag because I removed
configfs_alloc_group/configfs_free_group functions.

Thanks Christoph!
