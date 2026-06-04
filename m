Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A3B26290
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569538; cv=none; b=ETQdVI8dpSItirjO4qJTembjghwSbVJkIcyNbygsnI3f/Ix/6lEaOJmA9QCxKHjsg94n2m/+rIUXln2IN6YdE2ZKFM91vIdvkPMuFlQWDaEkomKZJPJ1z2dhmZY7eZXQdjqDWx2sGkUkt1A8E2Lg0RXPnv4ysO8x/6pzTpu4x80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569538; c=relaxed/simple;
	bh=A2FA4+4zqguO5QNN4RXEtflKaYVcPDCWYZtFRotBZ+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tmrp9r3RcwTp5yDqCB5UkwY3pSmNq87//Mcnz+Kr320L9ASmgq3POnkMSmv1j9j4rEeciuLengJdzikRU07QRyaVurbkjGl059oWxXIWsYeef7LIg2ZCe2ZxqGnwsT+Py2+i5yYdOYBEsjGZKVO1TD2aeTRf1aNZmi6utE5s1KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJThbBfd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJThbBfd"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490ac10e337so3101995e9.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 03:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780569535; x=1781174335; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6auMQAe41NOse7PoQBUlEGRJKpz7mD51EHhcTvl6K8E=;
        b=EJThbBfdSYYvLmtlLu19jSerqBmaWU+Vt35GeOabLIs09PB6x8rCrD4O/KKuH6vRLD
         UGSTUdX+93FUfaA3sgrGRMokNRRwDFm/Rrc2DJ7QEm743RAG2Vz26C14Ge8Wftoc0T2M
         e+7yCDWFP6kj/nYCBfLw9xxhyP2x4J/TMV8vpZIhhHQ1E/I4ml1+dZk9mk5bG+QiFMHL
         Arw3ogfnlGIDNZG4HT2ZSUHE850fkPBKgKesr7/SFBwAqYVDIfH7Su4/lC12/OKFWCLL
         QBrmuJhR+IVjhAV1bDy2iAKX2uLqZeHbNPejNPBXj1sZM+QU9tKrZkmlC2iOAVSOH9fw
         Z++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780569535; x=1781174335;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6auMQAe41NOse7PoQBUlEGRJKpz7mD51EHhcTvl6K8E=;
        b=XU6MKQhgbJ/vyVJVpOHtFc2Xk1ITBtfKsfGwZQehAM/SCwPVx1IZL7aXJquJfEotkG
         A/R3yFpH4aMihfSC3b8Cj1b0Q+u/NTVALcSTRppnCHFA9bdNRz5HxaMa47aQAhAoxtbx
         N++gu42qBYW+2RfR3I+rh2Dby727lX/8eyRgoU4EtIk00U4VN6Df0spattqnqqJwNm2+
         Z2mcHMO/BC5k4PkPG9pevLr1Aa58yiWmMeOyi/bHOkvTeFonmPjhTOFtzc4M6THy7cAf
         SsF2s8yIpEkhEi1K39M9FnPyPL3MlS9AkSoqjEgJUiY+abiteV+PKqvy0nMtGnHwp1XN
         a93w==
X-Forwarded-Encrypted: i=1; AFNElJ8yl7hTgvF/yyi9HBg41bTV/9Tyii1N0dQ4E7W6lFVH7vAsNu+QHDJPNCblED4hQvWlW2e5sXIkfr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpxnuyj83YeWq9GpMPBJohv8v/lg9hWH/8/ppq/j7VvltJAr7D
	t2w2LWrMa3cN8U/hEZ4NV/cNVyXkM7U+Rd2+CuxkjrPI1IPOveasCWMolob9W0VC
X-Gm-Gg: Acq92OEpAucpTXHralHH5ZtXkM5s57TTQpHjDMUP+bGBTqNCmMk6s3WXoPtTAaFtIwi
	8zhlYH5Aa20mnroHC5FBEHfJi/jzfEOW6VyQWmRdn7UwG5jR+nv8eAx8I3pXsyq+S8LjrO5pVdQ
	y0jH7N76Js3yynj4+f8QsmqL7TgLTwJYIPd4a5q8lnr8SGMS3ogigmaKzcSG22/HVIWU6SzZv5/
	a1e89PuWYg21lK8eShbqPo2FCIbsbgc0DEbfuQ1TadGXS0YaWITvlUMfDDepnN7CjjbKV24j92x
	cXvvuT1SB1/c3DE9E96T7OSvqUajKCBLcxRJ8BE2HYNt3Hyf93ADPfRdtdMWRzGrM/malGGrnMR
	UD7BOLONzqqBvta2rwLA8ORFaf3edyHxyEe25ZHcYoUyL47h4wlR/SwuewrzcLIUNiUFzRH+fmQ
	vfFxlZZpCLFBsr2/hToIrUQks2CxpDeg==
X-Received: by 2002:a05:600c:1551:b0:490:5466:8576 with SMTP id 5b1f17b1804b1-490b5e9fca9mr121187635e9.1.1780569535088;
        Thu, 04 Jun 2026 03:38:55 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d66c8sm56569815e9.10.2026.06.04.03.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 03:38:54 -0700 (PDT)
Date: Thu, 4 Jun 2026 13:38:50 +0300
From: Dan Carpenter <error27@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
Message-ID: <aiFVuvVtaWbjfVzA@stanley.mountain>
References: <ahP3O2tQdu4dNx_c@stanley.mountain>
 <CAKqfh0En4pHqSfxfd2FHSDTxfWx6BfJLfeQ3xup4bwfLSTrZRA@mail.gmail.com>
 <20260526191946.409160c8@jic23-huawei>
 <aiEpmqKwFuIMRfdl@ashevche-desk.local>
 <aiEtIGOFhF8AfUCT@stanley.mountain>
 <aiExQzpIOwPgwd3-@ashevche-desk.local>
 <aiE3N6zErq2WcCvS@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cRxskUAI1uPQGXpF"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiE3N6zErq2WcCvS@ashevche-desk.local>


--cRxskUAI1uPQGXpF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jun 04, 2026 at 11:28:39AM +0300, Andy Shevchenko wrote:
> On Thu, Jun 04, 2026 at 11:03:15AM +0300, Andy Shevchenko wrote:
> > On Thu, Jun 04, 2026 at 10:45:36AM +0300, Dan Carpenter wrote:
> > > On Thu, Jun 04, 2026 at 10:30:34AM +0300, Andy Shevchenko wrote:
> > > > On Tue, May 26, 2026 at 07:19:46PM +0100, Jonathan Cameron wrote:
> > > > > On Mon, 25 May 2026 08:20:31 -0500
> > > > > Maxwell Doose <m32285159@gmail.com> wrote:
> > > > > > On Mon, May 25, 2026 at 2:17 AM Dan Carpenter <error27@gmail.com> wrote:
> > > > > > >
> > > > > > > If the *ppos value is non-zero then simple_write_to_buffer() will not
> > > > > > > initialize the start of the buf[] buffer.  Non-zero ppos values aren't
> > > > > > > going to work at all.  Check for that at the start of the function and
> > > > > > > return -EINVAL.
> > > > > > 
> > > > > > Commit message is incorrect, it looks like you're returning -ENOSPC here...
> > > > > Tweaked and applied to the fixes-togreg branch of iio.git + marked for stable.
> > > > 
> > > > I was stumbled over these patches by Dan. Since the file_operations for the code
> > > > in question do not define .llseek, the seek is not supported and will return
> > > > -ESPIPE. I'm not sure why we have these patches to begin with. Dan, can you
> > > > elaborate on the case where the *ppos is not 0, please?
> > 
> > > The simple_write_to_buffer() will update *ppos so partial writes are
> > > supported in that way.
> > 
> > Can you show the step-by-step scenario? I'm still fail to see how it may be happen.
> > Is it somewhere inside the kernel loop? Which VFS function(s) is responsible for
> > that in such a case?
> 
> Even if ppos is advanced, the simple_write_to_buffer()
> https://elixir.bootlin.com/linux/v7.1-rc6/source/fs/libfs.c#L1188
> won't write more than available in the buffer. Is the available also
> being advanced somehow?

It's not a buffer overflow, it's an uninitialized data bug.

I used Google AI to create a test case but my qemu system is arm64
and the test case is in assembly so I'm not sure how useful it is.
(Also I modified the Google AI code and the test case is garbage).
My test case writes 10 bytes of data at a time.  I've attached the
test debugfs kernel module.

Here is the code from the kernel:

drivers/iio/industrialio-backend.c
   149  static ssize_t iio_backend_debugfs_write_reg(struct file *file,
   150                                               const char __user *userbuf,
   151                                               size_t count, loff_t *ppos)
   152  {
   153          struct iio_backend *back = file->private_data;
   154          unsigned int val;
   155          char buf[80];

buf is uninitialized.  In my test code, I initialized it to all U
characters which stands for uninitialized.

   156          ssize_t rc;
   157          int ret;
   158  
   159          if (*ppos != 0 || count >= sizeof(buf))
                    ^^^^^^^^^^
I added this check on *ppos but imagine it's not there and *ppos is
non-zero.

   160                  return -ENOSPC;
   161  
   162          rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);

The simple_write_to_buffer() function is designed to support partial
writes so it leaves the first 0 to *ppos characters alone.

   163          if (rc < 0)
   164                  return rc;
   165  
   166          buf[rc] = '\0';

The return is the number of characters written (starting at *ppos).  I'm
doing 10 character writes so it is 10.  The first 10 characters are
uninitialized.  In my test output you can see it prints ten U characters.

   167  
   168          ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
                             ^^^
Uninitialized variable.

   169  

root@test:/home/ubuntu/mnt/progs/tmp/sysfs# ./a.out 
Enter a line of text to save: 123456789012345678901234567890
[ 4266.853201] pos=0 count=10
[ 4266.853451] rc=10 buf 1234567890
[ 4266.854774] pos=10 count=10
Writing to file character by character...
[ 4266.858582] rc=10 buf UUUUUUUUUU
[ 4266.858698] pos=20 count=10
[ 4266.858740] rc=10 buf UUUUUUUUUU
[ 4266.858798] pos=30 count=10
[ 4266.858834] rc=10 buf UUUUUUUUUU
[ 4266.858888] pos=40 count=10
[ 4266.858924] rc=10 buf UUUUUUUUUU
[ 4266.859015] pos=50 count=10

regards,
dan carpenter

--cRxskUAI1uPQGXpF
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="hello_debugfs.c"

#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/debugfs.h>
#include <linux/fs.h>
#include <linux/uaccess.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Developer");
MODULE_DESCRIPTION("A Hello World Module with debugfs functionality");
MODULE_VERSION("1.0");

static struct dentry *dir_ret = NULL;
static struct dentry *file_ret = NULL;

// Triggered when a userspace process reads the debugfs file
static ssize_t hello_write(struct file *fp, const char __user *user_buffer, size_t count, loff_t *position)
{
	char buf[60] = "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
	int rc;

	pr_info("pos=%lld count=%lu\n", *position, count);

	rc = simple_write_to_buffer(buf, sizeof(buf), position, user_buffer, count);
	if (rc < 0)
		return rc;
	buf[rc] = '\0';

	pr_info("rc=%d buf %s\n", rc, buf);

	return count;
}

// Map the custom read logic to file operations structure
static const struct file_operations hello_fops = {
	.owner = THIS_MODULE,
	.write = hello_write,
};

// Module Initialization
static int __init hello_init(void)
{
	pr_info("hello_debugfs: Module loaded successfully\n");

	// 1. Create top-level parent directory in debugfs root
	dir_ret = debugfs_create_dir("hello_dir", NULL);
	if (IS_ERR(dir_ret)) {
		pr_err("hello_debugfs: Failed to create parent directory\n");
		return PTR_ERR(dir_ret);
	}

	// 2. Create target communication file inside the parent directory (Read-only for all: 0444)
	file_ret = debugfs_create_file("hello_file", 0444, dir_ret, NULL, &hello_fops);
	if (IS_ERR(file_ret)) {
		pr_err("hello_debugfs: Failed to create communication file\n");
		debugfs_remove_recursive(dir_ret);
		return PTR_ERR(file_ret);
	}

	return 0;
}

// Module Cleanup
static void __exit hello_exit(void)
{
	// Recursively destroys the created files and directory nodes
	debugfs_remove_recursive(dir_ret);
	pr_info("hello_debugfs: Module unloaded successfully\n");
}

module_init(hello_init);
module_exit(hello_exit);

--cRxskUAI1uPQGXpF--
