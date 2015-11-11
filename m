Return-Path: <jlbec@ftp.linux.org.uk>
Date: Wed, 11 Nov 2015 15:08:27 -0800
From: Joel Becker <jlbec@evilplan.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Baluta <daniel.baluta@intel.com>,
	jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de,
	linux-kernel@vger.kernel.org, octavian.purdila@intel.com,
	pebolle@tiscali.nl, patrick.porlan@intel.com,
	adriana.reus@intel.com, constantin.musca@intel.com,
	marten@intuitiveaerial.com, cristina.opriceana@gmail.com,
	pmeerw@pmeerw.net, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v10 1/5] configfs: Allow dynamic group creation
Message-ID: <20151111230826.GH4349@noexit.roam.corp.google.com>
References: <1445614411-533-1-git-send-email-daniel.baluta@intel.com>
 <1445614411-533-2-git-send-email-daniel.baluta@intel.com>
 <20151110065126.GA20339@lst.de>
 <20151110131237.894356c2ba17d8e9231509db@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151110131237.894356c2ba17d8e9231509db@linux-foundation.org>
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Nov 10, 2015 at 01:12:37PM -0800, Andrew Morton wrote:
> On Tue, 10 Nov 2015 07:51:26 +0100 Christoph Hellwig <hch@lst.de> wrote:
> 
> > is this simple addition something you could still send on to Linus
> > for this merge window?  I would make my life easier to have it in
> > so I could start using it in patches for various trees in the next
> > merge window.
> 
> It's super late, but the configfs changes are obviously safe to
> existing code.

Loving this change, even if this is merely a drive-by:

Acked-by: Joel Becker <jlbec@evilplan.org>

> 
> What about the IIO changes?  Will someone be merging them for 4.5-rc1,
> or something else?
> 

-- 

"Copy from one, it's plagiarism; copy from two, it's research."
        - Wilson Mizner

			http://www.jlbec.org/
			jlbec@evilplan.org
