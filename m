Return-Path: <SRS0=PRYC=YI=jic23.retrosnub.co.uk=jic23@kernel.org>
In-Reply-To: <20161225201409.GL1555@ZenIV.linux.org.uk>
References: <1482694902-7400-1-git-send-email-scott@matheina.com> <1482694902-7400-3-git-send-email-scott@matheina.com> <20161225201409.GL1555@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCHv4 2/8] Fixed variables not being consistently lower case
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Sun, 25 Dec 2016 22:34:54 +0000
To: Al Viro <viro@ZenIV.linux.org.uk>,Scott Matheina <scott@matheina.com>
CC: linux-kernel@vger.kernel.org,Lars-Peter Clausen <lars@metafoo.de>,Michael Hennerich <Michael.Hennerich@analog.com>,Jonathan Cameron <jic23@kernel.org>,Hartmut Knaack <knaack.h@gmx.de>,Peter Meerwald-Stadler <pmeerw@pmeerw.net>,Greg Kroah-Hartman <gregkh@linuxfoundation.org>,linux-iio@vger.kernel.org,devel@driverdev.osuosl.org
Message-ID: <A813EAC4-FE7C-4A1A-AB60-FCF699194E7B@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 25 December 2016 20:14:09 GMT+00:00, Al Viro <viro@ZenIV.linux.org.uk> wrote:
>On Sun, Dec 25, 2016 at 01:41:06PM -0600, Scott Matheina wrote:
>> Across the file, variables were sometimes upper case, some times
>> lower case, this fix addresses a few of the instances with this
>> inconsistency.
>
>NAK.  Go learn C and don't come back until you've done that.  If
>somebody
>has told you that you can contribute without knowing the language,
>they'd
>lied - you really can't.  And I would *STRONGLY* recommend to stay away
>from drivers/staging while you are learning C - it's like trying to use
>a public restroom wall as a sex-ed textbook.

Please can we keep things polite.

Jonathan
>
>While we are at it, it might be a good idea to check if the kernel
>builds after your changes and see what errors are produced.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
