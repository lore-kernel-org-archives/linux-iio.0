Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20150930014927.GA5399@kroah.com>
References: <56043868.1090601@kernel.org>
	<56043907.1020701@kernel.org>
	<20150930014927.GA5399@kroah.com>
Date: Wed, 30 Sep 2015 10:26:09 +0300
Message-ID: <CAEnQRZDamVs91F02tkzsLyoBRUK47O5ZKMzmdHXR9nx8okdBJA@mail.gmail.com>
Subject: Re: [PULL] 1st set of IIO new drivers, functionality and cleanups for
 the 4.4 cycle.
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Sep 30, 2015 at 4:49 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Sep 24, 2015 at 06:55:19PM +0100, Jonathan Cameron wrote:
>> On 24/09/15 18:52, Jonathan Cameron wrote:
>> > The following changes since commit 1c46ae0af6df0bbde66c5e868563be57f18a27b4:
>> >
>> >   Merge tag 'iio-for-4.3b-2' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2015-08-12 12:43:41 -0700)
>> >
>> > are available in the git repository at:
>> >
>> >   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.4a
>> >
>> > for you to fetch changes up to 1d2f1e084b7386b4082ebc2490ce0ddc8efe5667:
>> >
>> >   iio: light: apds9960: fix platform_no_drv_owner.cocci warnings (2015-09-23 20:23:30 +0100)
>> >
>> > ----------------------------------------------------------------
>> Just to note, there will be a few automerges.  The only manual one that
>> will need doing is in the devicetree vendors list file and is trivial.
>>
>> Bit of a mammoth set this time round!
>
> I've fixed up the vendor list file, that was easy, but the
> handle_simple_irq() api changed recently, so I had to add a patch to
> prevent things from breaking with this pull request.  If you could
> verify that I got everything right, that would be great as I've now
> pushed this out.

handle_simple_irq() api change looks good to me.

Thanks Greg!

Daniel.
