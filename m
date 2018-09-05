Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:56716 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeIEOjw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Sep 2018 10:39:52 -0400
Date: Wed, 05 Sep 2018 11:10:11 +0100
In-Reply-To: <20180905100700.kyrrnv2g3cw5d2wj@cf8e0945303d>
References: <20180905100700.kyrrnv2g3cw5d2wj@cf8e0945303d>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: IIO and linux-next?
To: Brian Masney <masneyb@onstation.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <D9E0E139-5A51-4A2D-82FA-AE96ABA6686C@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 5 September 2018 11:07:00 BST, Brian Masney <masneyb@onstation.org> wrote:
>Hi Jonathan,
>
>Should your IIO testing branch show up in linux-next? 
No this one is meant for independent testing.

>I don't see some
>of my recent commits (such as [1]) for the upcoming merge window in
>next. I don't see IIO in the list of trees for next [2] so I assume
>that it should go through Greg's staging-next tree then?

Yes.  It adds a few weeks of delay, but still gives plenty of time in Linux next.

Jonathan
>
>[1]
>https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=75de3b570b1c80f185df5289cb781e453fd64502
>[2]
>https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/diff/Next/Trees
>
>Thanks,
>
>Brian

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
