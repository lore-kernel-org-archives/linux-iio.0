Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE1324E4C6;
	Thu,  4 Jun 2026 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584780; cv=none; b=LNGE23wGcBpfp8hhvLFKUGv+QQisdYD8Pm/nRPyM+QpPnG+nH8eZwau9YvCWIoV+ClpNkW9lLDDZx0kC82LXR74g/Tx9Zn5RhbdFt/7hDjqzXlKIoJ0o7VkindR7yuGFxYXBBG29RQYXMJabsB6gyue5U8zPj0iutWpYjLFdwUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584780; c=relaxed/simple;
	bh=PFFS18fGXkBmAJzBywl0m3FV/3BpcxB4PCUQYefIrvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUSA4IIsAEubKs9ef0vGWz5ao0s27EBv9NCjDBMA4DU23dvDiEEq8lYG/6bs5X/tBJmz46Pf+6lM54/gXpnCIFyA1tjEdrkq7BKhVIfV1Dm7vWmWah5jEKQeQtSB5zcc37xQDOAkUi8w1UK4eOjvHgJc8lNR03degbkdnkk3f2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDGMIaTw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDGMIaTw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780584779; x=1812120779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PFFS18fGXkBmAJzBywl0m3FV/3BpcxB4PCUQYefIrvg=;
  b=mDGMIaTwvGHhmWF0odGsT0ezy/yUVfig9xHetcHF7mOjuBBy2ZmiAegd
   Aycpb37cTMqohPutdu6rw0BhVFbpu9puHR209BILyEenwO6o1HTnKi6wr
   rvf1Khb9www6y4JWJmQGkvztJY8i39DXVTgJZxadNAVVjqkltZ9/i1WrG
   YYA7H3WCCE9lrTlYkEhV3LyBzPmK9b+qIgx7pkZ4Rx6QwGZm5xWq+Py7J
   dObYqI8KBvT7Tvuco2Zsw3bFpTt75fzVF4DaZaY2JKzDEhaCaS6nvKvw8
   2bkSMguO4N/8b27iTyy9OWUtoT8dhjrFe39tY9svkwmOUBSWrVVGRSfxf
   Q==;
X-CSE-ConnectionGUID: yhUSo2KvRQa++gRxhsOlbw==
X-CSE-MsgGUID: 4UYWCzVhSKC/q7Po4I5AjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="80552062"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="80552062"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 07:52:58 -0700
X-CSE-ConnectionGUID: v37vaXfaTuWht3t7ETZh/w==
X-CSE-MsgGUID: eUbmcpguSkO3K7ooVjZ+gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="243489388"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 07:52:56 -0700
Date: Thu, 4 Jun 2026 17:52:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
Message-ID: <aiGRRbOMmEyGbIM0@ashevche-desk.local>
References: <ahP3O2tQdu4dNx_c@stanley.mountain>
 <CAKqfh0En4pHqSfxfd2FHSDTxfWx6BfJLfeQ3xup4bwfLSTrZRA@mail.gmail.com>
 <20260526191946.409160c8@jic23-huawei>
 <aiEpmqKwFuIMRfdl@ashevche-desk.local>
 <aiEtIGOFhF8AfUCT@stanley.mountain>
 <aiExQzpIOwPgwd3-@ashevche-desk.local>
 <aiE3N6zErq2WcCvS@ashevche-desk.local>
 <aiFVuvVtaWbjfVzA@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiFVuvVtaWbjfVzA@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 01:38:50PM +0300, Dan Carpenter wrote:
> On Thu, Jun 04, 2026 at 11:28:39AM +0300, Andy Shevchenko wrote:
> > On Thu, Jun 04, 2026 at 11:03:15AM +0300, Andy Shevchenko wrote:
> > > On Thu, Jun 04, 2026 at 10:45:36AM +0300, Dan Carpenter wrote:
> > > > On Thu, Jun 04, 2026 at 10:30:34AM +0300, Andy Shevchenko wrote:
> > > > > On Tue, May 26, 2026 at 07:19:46PM +0100, Jonathan Cameron wrote:
> > > > > > On Mon, 25 May 2026 08:20:31 -0500
> > > > > > Maxwell Doose <m32285159@gmail.com> wrote:
> > > > > > > On Mon, May 25, 2026 at 2:17 AM Dan Carpenter <error27@gmail.com> wrote:
> > > > > > > >
> > > > > > > > If the *ppos value is non-zero then simple_write_to_buffer() will not
> > > > > > > > initialize the start of the buf[] buffer.  Non-zero ppos values aren't
> > > > > > > > going to work at all.  Check for that at the start of the function and
> > > > > > > > return -EINVAL.
> > > > > > > 
> > > > > > > Commit message is incorrect, it looks like you're returning -ENOSPC here...
> > > > > > Tweaked and applied to the fixes-togreg branch of iio.git + marked for stable.
> > > > > 
> > > > > I was stumbled over these patches by Dan. Since the file_operations for the code
> > > > > in question do not define .llseek, the seek is not supported and will return
> > > > > -ESPIPE. I'm not sure why we have these patches to begin with. Dan, can you
> > > > > elaborate on the case where the *ppos is not 0, please?
> > > 
> > > > The simple_write_to_buffer() will update *ppos so partial writes are
> > > > supported in that way.
> > > 
> > > Can you show the step-by-step scenario? I'm still fail to see how it may be happen.
> > > Is it somewhere inside the kernel loop? Which VFS function(s) is responsible for
> > > that in such a case?
> > 
> > Even if ppos is advanced, the simple_write_to_buffer()
> > https://elixir.bootlin.com/linux/v7.1-rc6/source/fs/libfs.c#L1188
> > won't write more than available in the buffer. Is the available also
> > being advanced somehow?
> 
> It's not a buffer overflow, it's an uninitialized data bug.
> 
> I used Google AI to create a test case but my qemu system is arm64
> and the test case is in assembly so I'm not sure how useful it is.
> (Also I modified the Google AI code and the test case is garbage).
> My test case writes 10 bytes of data at a time.  I've attached the
> test debugfs kernel module.
> 
> Here is the code from the kernel:
> 
> drivers/iio/industrialio-backend.c
>    149  static ssize_t iio_backend_debugfs_write_reg(struct file *file,
>    150                                               const char __user *userbuf,
>    151                                               size_t count, loff_t *ppos)
>    152  {
>    153          struct iio_backend *back = file->private_data;
>    154          unsigned int val;
>    155          char buf[80];
> 
> buf is uninitialized.  In my test code, I initialized it to all U
> characters which stands for uninitialized.
> 
>    156          ssize_t rc;
>    157          int ret;
>    158  
>    159          if (*ppos != 0 || count >= sizeof(buf))
>                     ^^^^^^^^^^
> I added this check on *ppos but imagine it's not there and *ppos is
> non-zero.
> 
>    160                  return -ENOSPC;
>    161  
>    162          rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);
> 
> The simple_write_to_buffer() function is designed to support partial
> writes so it leaves the first 0 to *ppos characters alone.

If you wrote as many bytes as required, *ppos left on the 'count', and next
writes go after that. So, why *ppos is not 0? Maybe the issue that we need
somewhere reset *ppos to 0?

>    163          if (rc < 0)
>    164                  return rc;
>    165  
>    166          buf[rc] = '\0';
> 
> The return is the number of characters written (starting at *ppos).  I'm
> doing 10 character writes so it is 10.  The first 10 characters are
> uninitialized.  In my test output you can see it prints ten U characters.
> 
>    167  
>    168          ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
>                              ^^^
> Uninitialized variable.
> 
>    169  

> # ./a.out 
> Enter a line of text to save: 123456789012345678901234567890
> [ 4266.853201] pos=0 count=10
> [ 4266.853451] rc=10 buf 1234567890
> [ 4266.854774] pos=10 count=10
> Writing to file character by character...
> [ 4266.858582] rc=10 buf UUUUUUUUUU
> [ 4266.858698] pos=20 count=10
> [ 4266.858740] rc=10 buf UUUUUUUUUU
> [ 4266.858798] pos=30 count=10
> [ 4266.858834] rc=10 buf UUUUUUUUUU
> [ 4266.858888] pos=40 count=10
> [ 4266.858924] rc=10 buf UUUUUUUUUU
> [ 4266.859015] pos=50 count=10

-- 
With Best Regards,
Andy Shevchenko


