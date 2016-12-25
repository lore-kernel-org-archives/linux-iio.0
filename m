Return-Path: <SRS0=xaim=YI=ftp.linux.org.uk=viro@kernel.org>
Date: Sun, 25 Dec 2016 20:14:09 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Scott Matheina <scott@matheina.com>
Cc: linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCHv4 2/8] Fixed variables not being consistently lower case
Message-ID: <20161225201409.GL1555@ZenIV.linux.org.uk>
References: <1482694902-7400-1-git-send-email-scott@matheina.com>
 <1482694902-7400-3-git-send-email-scott@matheina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1482694902-7400-3-git-send-email-scott@matheina.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Dec 25, 2016 at 01:41:06PM -0600, Scott Matheina wrote:
> Across the file, variables were sometimes upper case, some times
> lower case, this fix addresses a few of the instances with this
> inconsistency.

NAK.  Go learn C and don't come back until you've done that.  If somebody
has told you that you can contribute without knowing the language, they'd
lied - you really can't.  And I would *STRONGLY* recommend to stay away
from drivers/staging while you are learning C - it's like trying to use
a public restroom wall as a sex-ed textbook.

While we are at it, it might be a good idea to check if the kernel
builds after your changes and see what errors are produced.
