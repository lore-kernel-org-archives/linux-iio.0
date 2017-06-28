Return-Path: <SRS0=X3YG=6B=googlemail.com=martin.blumenstingl@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170627064354.GA29793@kroah.com>
References: <14984537865458@kroah.com> <CAFBinCDOSaHF9GwGhMUpZjR7AUVWVwk7EJmHWt0q8bkChBhMZA@mail.gmail.com>
 <20170627064354.GA29793@kroah.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 28 Jun 2017 22:12:31 +0200
Message-ID: <CAFBinCC7g6WusieUak7eLi2NgbCNG5QB9Apr9A5eMei36yaFuw@mail.gmail.com>
Subject: Re: patch "iio: adc: meson-saradc: use NULL instead of 0 for pointer"
 added to staging-testing
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jic23@kernel.org, paolocretaro@gmail.com,
	linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

On Tue, Jun 27, 2017 at 8:43 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, Jun 26, 2017 at 08:57:18PM +0200, Martin Blumenstingl wrote:
>> Hi Greg, Hi Jonathan,
>>
>> On Mon, Jun 26, 2017 at 7:09 AM,  <gregkh@linuxfoundation.org> wrote:
>> >
>> > This is a note to let you know that I've just added the patch titled
>> >
>> >     iio: adc: meson-saradc: use NULL instead of 0 for pointer
>> >
>> > to my staging git tree which can be found at
>> >     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
>> > in the staging-testing branch.
>> >
>> > The patch will show up in the next release of the linux-next tree
>> > (usually sometime within the next 24 hours during the week.)
>> >
>> > The patch will be merged to the staging-next branch sometime soon,
>> > after it passes testing, and the merge window is open.
>> >
>> > If you have any questions about this process, please let me know.
>> is there a way to drop below patch from your repo?
>> during testing I found out that the code before and after this patch
>> leads to a NULL deref. I provided a fix (see [0]) which solves the
>> crash and the warning as reported by Paolo - and that fix is already
>> part of v4.12-rc6
>> so the patch below will cause a merge conflict
>
> I already handled the merge conflict, can you verify I got it right in
> my tree?
I just checked your staging.git/staging-testing branch: it seems that
the conflict was resolved correctly (meaning that Paolo's patch is
non-existent in your tree, which is correct)


Regards,
Martin
