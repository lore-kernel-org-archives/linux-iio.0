Return-Path: <jic23@jic23.retrosnub.co.uk>
References: <500309B8.60009@kernel.org> <20120717005843.GA16382@kroah.com> <50059E28.1080809@kernel.org> <20120717173004.GA17718@kroah.com>
In-Reply-To: <20120717173004.GA17718@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="----5DLCKCHKPAT35X9JHWYEUO18W7LM0T"
Subject: Re: [GIT PULL v2] iio fixes for staging/staging-next.
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Tue, 17 Jul 2012 18:38:35 +0100
To: Greg KH <gregkh@linuxfoundation.org>,Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <9f3bcfc8-2f9d-4435-9677-64005c64edc8@email.android.com>
List-ID: <linux-iio@vger.kernel.org>

------5DLCKCHKPAT35X9JHWYEUO18W7LM0T
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit


Sorry for wasting your time with the screw ups. As ever your advice and help is much appreciated!

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.

Greg KH <gregkh@linuxfoundation.org> wrote:

On Tue, Jul 17, 2012 at 06:17:28PM +0100, Jonathan Cameron wrote:
> 
> The following changes since commit 2b6e6b8042a9f783170b0a15e0550a075381726e:
> 
> staging: comedi: rtd520: remove RtdDio0Read macro (2012-07-13 08:12:31 -0700)
> 
> are available in the git repository at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-3.6b
> 
> for you to fetch changes up to dcbc3c414e62faa4e1a1e17421f89eceea6bee30:
> 
> iio staging: fix cast warning and cleanup alignment code (2012-07-15 17:33:18 +0100)
> 
>_____________________________________________

> IIO fixes for elements queued for 3.6 merge window.
> 
> 3 types of fix here.
> 
> 1) Incorrect pointer casting via phys_addr_t which causes
> trouble on some architectures.
> 2) request_irq and free_irq dev_id parameters not matching.
> 3) Inconsistencies in client_data for some i2c devices
> (writing one pointer and expecting another later).

Yeah!

That all looks great, thanks for working with me on these little
complaints, I appreciate it.

All pulled and pushed out, thanks.

greg k-h


------5DLCKCHKPAT35X9JHWYEUO18W7LM0T
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head></head><body><br>
Sorry for wasting your time with the screw ups.  As ever your advice and help is much appreciated!<br>
<br>
-- <br>
Sent from my Android phone with K-9 Mail. Please excuse my brevity.<br><br><div class="gmail_quote">Greg KH &lt;gregkh@linuxfoundation.org&gt; wrote:<blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre style="white-space: pre-wrap; word-wrap:break-word; font-family: sans-serif">On Tue, Jul 17, 2012 at 06:17:28PM +0100, Jonathan Cameron wrote:<br />&gt; <br />&gt; The following changes since commit 2b6e6b8042a9f783170b0a15e0550a075381726e:<br />&gt; <br />&gt;   staging: comedi: rtd520: remove RtdDio0Read macro (2012-07-13 08:12:31 -0700)<br />&gt; <br />&gt; are available in the git repository at:<br />&gt; <br />&gt;   git://<a href="http://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git">git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git</a> tags/iio-fixes-3.6b<br />&gt; <br />&gt; for you to fetch changes up to dcbc3c414e62faa4e1a1e17421f89eceea6bee30:<br />&gt; <br />&gt;   iio staging: fix cast warning and cleanup alignment code (2012-07-15 17:33:18 +0100)<br />&gt; <br />&gt;<hr /><br />&gt; IIO fixes for elements queued for 3.6 merge window.<br />&gt; <br />&gt; 3 types of fix here.<br />&gt; <br />&gt; 1) Incorrect pointer casting via phys_addr_t which
causes<br />&gt;    trouble on some architectures.<br />&gt; 2) request_irq and free_irq dev_id parameters not matching.<br />&gt; 3) Inconsistencies in client_data for some i2c devices<br />&gt; (writing one pointer and expecting another later).<br /><br />Yeah!<br /><br />That all looks great, thanks for working with me on these little<br />complaints, I appreciate it.<br /><br />All pulled and pushed out, thanks.<br /><br />greg k-h<br /></pre></blockquote></div></body></html>
------5DLCKCHKPAT35X9JHWYEUO18W7LM0T--
