Return-Path: <jic23@cam.ac.uk>
Message-ID: <4DA34AA5.3020700@cam.ac.uk>
Date: Mon, 11 Apr 2011 19:38:29 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 arnd@arndb.de, tglx@linutronix.de
Subject: Re: [RFC PATCH 00/21] IIO: Channel registration rework, buffer chardev
 combining and rewrite of triggers as 'virtual' irq_chips.
References: <1301583255-28468-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1301583255-28468-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>


Just a quick heads up.  I am not intending to repost this series
to lkml.  Given with carrying drivers through past 
"staging:iio: Remove legacy event handling" has resulted
in over 50 patches that are mostly very much driver specific,
it seems silly to bombard the general list.

I will be posting that set on linux-iio if anyone is interested
(after a little more cleaning up).

I will cherry pick a few bits such as the additional
exports from genirq to post to lkml.

Seems rude to drop a huge patch set on everyone when
only a few corners will be of general interest.

Jonathan
