Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:46247 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbbKGNJv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 7 Nov 2015 08:09:51 -0500
Date: Sat, 7 Nov 2015 14:09:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Joel Becker <jlbec@evilplan.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>, patrick.porlan@intel.com,
	Adriana Reus <adriana.reus@intel.com>,
	constantin.musca@intel.com, marten@intuitiveaerial.com,
	Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v10 1/5] configfs: Allow dynamic group creation
Message-ID: <20151107130947.GA23086@lst.de>
References: <1445614411-533-1-git-send-email-daniel.baluta@intel.com> <1445614411-533-2-git-send-email-daniel.baluta@intel.com> <20151106075008.GA30535@lst.de> <CAEnQRZBjy3jnNFA77nrY+3h93MsEqGMko4cicqMP-RHBhLx0UQ@mail.gmail.com> <563C736D.6050705@metafoo.de> <A334FE9C-F187-4304-AA98-6A40347AF731@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A334FE9C-F187-4304-AA98-6A40347AF731@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Nov 06, 2015 at 05:38:53PM +0000, Jonathan Cameron wrote:
> Yup. I'd have no objection to a direct request to Linus to take this as a one off. 

I'd appreciate if you could give it a try.

> Or we can do an immutable branch and pull it into all relevant subtrees so all
> users can hit mainline all in 4.5 without waiting for a cycle. That tends to work well for bits like this.

That would be the second best option.
