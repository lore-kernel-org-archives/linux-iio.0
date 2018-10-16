Return-Path: <SRS0=ZW6H=M4=usp.br=giuliano.belinassi@kernel.org>
MIME-Version: 1.0
References: <20181016210950.cmx4r4pb2yg5ofpp@smtp.gmail.com>
 <5717d448daad72d7eb142732ca88e9ed30854088.camel@perches.com>
 <CAG4RSAFMGSFyUqutRD2SRMsBt5RHVo5RUQsBq7fis6OVWxSZbg@mail.gmail.com> <d00fec12b481f17ce6e844d86be56b5f12bdb0b1.camel@perches.com>
In-Reply-To: <d00fec12b481f17ce6e844d86be56b5f12bdb0b1.camel@perches.com>
From: Giuliano Augusto Faulin Belinassi <giuliano.belinassi@usp.br>
Date: Tue, 16 Oct 2018 20:29:39 -0300
Message-ID: <CAEFO=4DQ7yN33VwW5evNgdMTDf1c_Sffwue_PFT_RvytJst+Bg@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: ad7280a: Lines should not end with a '(' - style
To: joe@perches.com
Cc: giuliano.belinassi@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

>(There is a linux-usp@googlegroups.com mailing list
>that bounces when I reply, so I removed it from the
>cc list)

Sorry. I think this may be because my HTML mode in gmail was enabled.

> I wrote that to encourage you to do more than
> what checkpatch says.

> I just moved code around and reduced duplication.

> There are many similar opportunities for code
> refactoring in staging.

Thank you :-) I will put effort to improve these points.

> You could test what I wrote, add a good commit
> message with a subject like:
>
> [PATCH V2] staging: iio: ad7280a: Refactor <functionname>
>
> with a commit message that describes the changes and
> perhaps shows the object size difference using
>
> $ size <old> <new>

I will do that. :-)

> Are you doing this for a class assignment?
Yes, I am. I am into a group that aims to contribute to opensource
projects and we chose the Linux kernel. Our mentor suggested us to
contribute to the linux-iio

Thank you
On Tue, Oct 16, 2018 at 8:08 PM Joe Perches <joe@perches.com> wrote:
>
> (There is a linux-usp@googlegroups.com mailing list
> that bounces when I reply, so I removed it from the
> cc list)
>
> On Tue, 2018-10-16 at 19:48 -0300, Giuliano Belinassi wrote:
> > Hello,
> >     Thank you for your review :-).
> >     Sorry, but I am a newbie on this, and now I am confused about my next
> > step. Should I make a v2 based on your changes, or do you want to submit
> > your changes?
>
> I wrote that to encourage you to do more than
> what checkpatch says.
>
> I just moved code around and reduced duplication.
>
> There are many similar opportunities for code
> refactoring in staging.
>
> You could test what I wrote, add a good commit
> message with a subject like:
>
> [PATCH V2] staging: iio: ad7280a: Refactor <functionname>
>
> with a commit message that describes the changes and
> perhaps shows the object size difference using
>
> $ size <old> <new>
>
> Maybe add a Suggested-by: tag if it pleases you, but
> what I did is trivial and I think it's unnecessary.
>
> Are you doing this for a class assignment?
>
>
