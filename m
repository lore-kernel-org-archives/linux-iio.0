Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-032.synserver.de ([212.40.185.32]:1472 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1032984AbbKFJd3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 6 Nov 2015 04:33:29 -0500
Message-ID: <563C736D.6050705@metafoo.de>
Date: Fri, 06 Nov 2015 10:31:25 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>
CC: Joel Becker <jlbec@evilplan.org>,
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
References: <1445614411-533-1-git-send-email-daniel.baluta@intel.com>	<1445614411-533-2-git-send-email-daniel.baluta@intel.com>	<20151106075008.GA30535@lst.de> <CAEnQRZBjy3jnNFA77nrY+3h93MsEqGMko4cicqMP-RHBhLx0UQ@mail.gmail.com>
In-Reply-To: <CAEnQRZBjy3jnNFA77nrY+3h93MsEqGMko4cicqMP-RHBhLx0UQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/06/2015 09:48 AM, Daniel Baluta wrote:
> On Fri, Nov 6, 2015 at 9:50 AM, Christoph Hellwig <hch@lst.de> wrote:
>> Is this going into 4.4 through the iio tree?  If not is there any chance
>> to get it in through some other tree?  While we're not past the merge
>> window is trivial new functionality that doesn't change code, and I'd like to
>> move existing configfs users over to it ASAP, so getting it into a baseline
>> tree ASAP would be immensely helpful.
> 
> I think Jonathan could take this via linux-iio around Sunday.
> 

Since the IIO tree goes through the staging tree, which is already closed
for 4.4, we won't be able to get it into 4.4 through the IIO tree. The whole
configfs support for IIO will have to wait for 4.5.

> Could anyone do it faster :)? Andrew?
