Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45027 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247Ab3ALWCt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Jan 2013 17:02:49 -0500
Message-ID: <50F1DD83.2080301@kernel.org>
Date: Sat, 12 Jan 2013 22:02:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: iio: STMicroelectronics iio drivers bugfix
References: <1357733221-6248-1-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1357733221-6248-1-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/2013 12:06 PM, Denis CIOCCA wrote:
> Hi guys,
> 
> sorry but yesterday I sended to you the wrong patch! I attach the last (correct) patchs for the linux-next kernel and I have modified the config names in according with Alessandro suggestion.
> Thanks
> 
> Denis
> 
Hi Denis,

Just a quick email to say I'm very happy with the state these patches are
now in.  I have one utterly trivial point on patch 1 but am happy to fix
that up during the merge.  (Basically you type cast a parameter to u16 instead
of __le16).

However, given the size of the series I would like to leave them sitting
on the mailing list for a little while (maybe until next Saturday given
my usual timetable for such things) in case anyone else wants to review
them.  Also right now I've only looked at 1 and 2 (assuming the others are
very similar for obvious reasons!) I will give them a look before merging
just in case anything slipped by.

Thanks for all your work on these. When I get some time I'll see what is needed
to add support for the lis3l02dq to this driver.  From what I recall that
chip is a little dumber than some of the newer ones and needs some uggly
interrupt handling trickery.  Given it's an ancient chip I doubt it is
terribly high on your list to support.  I just happen to have one on my
test board so it's always been of inordinate interest to me ;)

Jonathan
