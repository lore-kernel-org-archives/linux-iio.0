Return-Path: <lars@metafoo.de>
Message-ID: <524DA508.2030606@metafoo.de>
Date: Thu, 03 Oct 2013 19:10:32 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: IIO hrtimer trigger
References: <1380483412-13458-1-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1380483412-13458-1-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 09/29/2013 09:36 PM, Denis CIOCCA wrote:
> Hi Lars,
> 
> Thanks for your review.
> I reviewed the code in accordance with your comments, for the other point
> can you explain me better please?
> You intend to use one driver to manage all triggers added by sysfs?

Not necessarily, but I think we should have some common code that manages
the software triggers. But what I'm most concerned about is the userspace
ABI, since once we have added it, we have to maintain it forever. So the big
question do we think that the current ABI implemented by that patch is good
enough. Some thoughts:

* Should it maybe be called timer instead of hrtimer.
* Do we only want to allow names which follow "hrtimer-%d" or do we want to
allow arbitrary names.
* Do we want to have a top-level folder for each sw trigger type
* Is sysfs actually the right place for this, or should it go into configfs?
  Quote from Documentation/filesystems/configs:
  "configfs is a ram-based filesystem that provides the converse of
   sysfs's functionality.  Where sysfs is a filesystem-based view of
   kernel objects, configfs is a filesystem-based manager of kernel
   objects, or config_items. [...] Unlike sysfs, the
   lifetime of the representation is completely driven by userspace.  The
   kernel modules backing the items must respond to this."

I think especially the last one deserves some though.

- Lars
