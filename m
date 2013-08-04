Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47357 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535Ab3HDPV7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Aug 2013 11:21:59 -0400
Message-ID: <51FE7FAB.8050608@kernel.org>
Date: Sun, 04 Aug 2013 17:22:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Jacek Anaszewski <j.anaszewski@samsung.com>,
	linux-iio@vger.kernel.org, denis.ciocca@st.com,
	devicetree-discuss@lists.ozlabs.org, l.czerwinski@samsung.com,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH v2] iio: lps331ap: Add support for DT
References: <1374240981-13560-1-git-send-email-j.anaszewski@samsung.com> <1374240981-13560-2-git-send-email-j.anaszewski@samsung.com> <51FE4117.3040404@kernel.org> <51FE4267.2090409@kernel.org> <20130804120854.GV2911@lukather>
In-Reply-To: <20130804120854.GV2911@lukather>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/04/13 13:08, Maxime Ripard wrote:
> Hi Jonathan,
> 
> On Sun, Aug 04, 2013 at 01:00:39PM +0100, Jonathan Cameron wrote:
>> On 08/04/13 12:55, Jonathan Cameron wrote:
>>> On 07/19/13 14:36, Jacek Anaszewski wrote:
>>>> This patch adds DT support for the lps331ap barometer sensor.
>>>> 
>>>> Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com> Signed-off-by: Kyungmin Park
>>>> <kyungmin.park@samsung.com>
>>> This makes sense to me and looks similar to that in existing bindings hence,
>>> 
>>> Applied to the togreg branch of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>> Actually I've backed this change out as I've just read a few more emails down my backlog and found a long
>> discussion of it when it got pulled into another patch set.  Will review that discussion before making any
>> decisions on this one.
> 
> Also, a new process begin to emerge, and now, every new bindings should be acked by the new device tree
> maintainers. I'm not sure the discussion on the exact process has been settled, so that's probably why not all the
> maintainers are aware of that, but this ACK is (or will be) required for every new binding that comes in, and this
> should be enforced by all maintainers.
> 
> The underlying thinking is that DT bindings should be a stable ABI, and as such be properly reviewed, instead of
> just being looked at by the other maintainers that are often not interested or just don't really know about DT at
> all.
> 
> You can see parts of this discussion here: 
> https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-July/038275.html 
> https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-July/038264.html 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/186420.html
> 
Thanks for the heads up. I'd picked up on this a little via LWN. Hopefully
the process will become clear shortly.



Jonathan
