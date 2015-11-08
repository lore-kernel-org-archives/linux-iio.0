Return-Path: <jic23@kernel.org>
Subject: Re: [PATCH v10 1/5] configfs: Allow dynamic group creation
To: Christoph Hellwig <hch@lst.de>,
 Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
References: <1445614411-533-1-git-send-email-daniel.baluta@intel.com>
 <1445614411-533-2-git-send-email-daniel.baluta@intel.com>
 <20151106075008.GA30535@lst.de>
 <CAEnQRZBjy3jnNFA77nrY+3h93MsEqGMko4cicqMP-RHBhLx0UQ@mail.gmail.com>
 <563C736D.6050705@metafoo.de>
 <A334FE9C-F187-4304-AA98-6A40347AF731@jic23.retrosnub.co.uk>
 <20151107130947.GA23086@lst.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Daniel Baluta <daniel.baluta@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Joel Becker <jlbec@evilplan.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "octavian.purdila@intel.com" <octavian.purdila@intel.com>,
 Paul Bolle <pebolle@tiscali.nl>, patrick.porlan@intel.com,
 Adriana Reus <adriana.reus@intel.com>, constantin.musca@intel.com,
 marten@intuitiveaerial.com,
 Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>,
 Peter Meerwald <pmeerw@pmeerw.net>, viro@zeniv.linux.org.uk,
 Greg KH <gregkh@linuxfoundation.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <563F6A7B.8000507@kernel.org>
Date: Sun, 8 Nov 2015 15:30:03 +0000
MIME-Version: 1.0
In-Reply-To: <20151107130947.GA23086@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 07/11/15 13:09, Christoph Hellwig wrote:
> On Fri, Nov 06, 2015 at 05:38:53PM +0000, Jonathan Cameron wrote:
>> Yup. I'd have no objection to a direct request to Linus to take this as a one off. 
> 
> I'd appreciate if you could give it a try.
Unfortunately this would fall out of scope for me to send.  The bit we care
about is definitely a file system code change in configfs.  Whilst
the first user will probably be IIO, I can't justify to Linus why 
it is necessary to put this in place ASAP rather than via normal paths
(which in my case is via Greg)

If Joel was active I'd suggest it should come from him if we want to try
this, as he isn't (as a side note, we should probably update the MAINTAINERS
entry to mark it as unmaintained I guess), who ends up being maintainer of
last resort for file systems?
<quick git log browse later>

I'd say you need to make a case to Al Viro or Andrew Morton.

> 
>> Or we can do an immutable branch and pull it into all relevant subtrees so all
>> users can hit mainline all in 4.5 without waiting for a cycle. That tends to work well for bits like this.
> 
> That would be the second best option.
I can do this easily enough and it's probably my preferred option.  

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
