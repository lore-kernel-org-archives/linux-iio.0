Return-Path: <SRS0=7S50=NF=gmail.com=himanshujha199640@kernel.org>
Date: Thu, 25 Oct 2018 20:25:20 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Renato Lui Geh <renatogeh@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael.Hennerich@analog.com,
	jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, alexandru.Ardelean@analog.com,
	stefan.popa@analog.com, giuliano.belinassi@usp.br,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad7780: update voltage on read
Message-ID: <20181025145520.GA16950@himanshu-Vostro-3559>
References: <20181025133223.kn7cjlyep7bmx2mm@renatolg>
 <c958f5fc-2a58-8471-62a4-20b0c7267bd0@metafoo.de>
 <20181025142635.3apgyaxzhr73kehc@renatolg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181025142635.3apgyaxzhr73kehc@renatolg>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Oct 25, 2018 at 11:26:36AM -0300, Renato Lui Geh wrote:
> Hi,
> 
> Thanks for the quick review. :)
> 
> > But please create one patch per issue and do not put unrelated changes into
> > the same patch.
> 
> Should I resend this patch as a patchset containing the two changes?

Yes! "One patch per change policy"

> > Also your mail client seems to have replaced tabs in the patch with spaces,
> > this means the patch will not apply cleanly. Check the
> > Documentation/email-clients.txt file for some hints how to configure your
> > mail client so it will not break patches.
> 
> From my end my original email patch appears to have tabs instead of
> spaces. I redownloaded my email and vim shows that the indentation has
> the ^I tab characters. But when downloading your reply it was converted
> to spaces. Am I missing something?

Your patch applies fine.

I think the problem is on Lars end due to Thunderbird.

In the meantime, you can verify the patch using:

$ git am <your_patch.patch>

Also, you can try to use `git send-email` to send patches.


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
