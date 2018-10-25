Return-Path: <SRS0=qdDs=NF=gmail.com=renatogeh@kernel.org>
From: Renato Lui Geh <renatogeh@gmail.com>
Date: Thu, 25 Oct 2018 11:26:36 -0300
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Renato Lui Geh <renatogeh@gmail.com>, Michael.Hennerich@analog.com,
	jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, alexandru.Ardelean@analog.com,
	stefan.popa@analog.com, giuliano.belinassi@usp.br,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad7780: update voltage on read
Message-ID: <20181025142635.3apgyaxzhr73kehc@renatolg>
References: <20181025133223.kn7cjlyep7bmx2mm@renatolg>
 <c958f5fc-2a58-8471-62a4-20b0c7267bd0@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
In-Reply-To: <c958f5fc-2a58-8471-62a4-20b0c7267bd0@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Hi,

Thanks for the quick review. :)

>But please create one patch per issue and do not put unrelated changes into
>the same patch.

Should I resend this patch as a patchset containing the two changes?

>Also your mail client seems to have replaced tabs in the patch with spaces,
>this means the patch will not apply cleanly. Check the
>Documentation/email-clients.txt file for some hints how to configure your
>mail client so it will not break patches.

>From my end my original email patch appears to have tabs instead of
spaces. I redownloaded my email and vim shows that the indentation has
the ^I tab characters. But when downloading your reply it was converted
to spaces. Am I missing something?

Thanks again,
Renato
