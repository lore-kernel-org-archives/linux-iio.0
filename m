Return-Path: <rubini@mail.gnudd.com>
Date: Fri, 2 Dec 2011 17:44:23 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: rupran@einserver.de
Cc: devel@linuxdriverproject.org, gregkh@suse.de, jic23@cam.ac.uk,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] Staging: iio/accel: Changed data type of mask in
 store_measurement_mode() to u8
Message-ID: <20111202164423.GA14982@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: rubini@gnudd.com
In-Reply-To: <1322843423-18178-1-git-send-email-rupran@einserver.de>
References: <1322843423-18178-1-git-send-email-rupran@einserver.de>
  <4ED7EE04.3010308@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

> As we are only interested in the lowest two bytes here and mask is
> initialized with a fixed value 0x03, mask may as well be a u8.

s/bytes/bits/

It's not a trivial typo, the reader can be confused (I've been)

/alessandro
