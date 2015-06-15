Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54626 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755796AbbFORUh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jun 2015 13:20:37 -0400
In-Reply-To: <2d05200efc42012bd16be4dde0fad85d.squirrel@mungewell.org>
References: <2d05200efc42012bd16be4dde0fad85d.squirrel@mungewell.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: ST driver - ad-hoc allocation of trigger interrupt
From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 15 Jun 2015 18:20:26 +0100
To: simon@mungewell.org, linux-iio@vger.kernel.org
Message-ID: <A077DCB2-204C-40BC-881D-83CAEF418A6C@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 15 June 2015 16:04:58 BST, simon@mungewell.org wrote:
>Hi all,
>A friend and I were attempting to get a LSM303DLHC breakout board
>hooked
>up to the expansion header on the RaspPi yesterday - it was him doing
>the
>work and me offering suggestions from afar (unfortunately the blind
>leading the blind)...
>
>Anyhow 'we' got reasonably far and could read raw value and trigger the
>buffer via the 'iio-sysfs-trig'. The problem came when we wanted the
>device to trigger itself at the set sample frequency.
>
>We infer that we need to connect the DRDY signal to a CPU interrupt
>line,
>but can't see how we tell the ST iio driver which one.
>
>I did find this is the source:
>https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/common/st_sensors/st_sensors_trigger.c?id=refs/tags/v4.1-rc8#n21
>
>Which shows that the 'sdata->get_irq_data_ready()' can be pre-defined
>in
>the data structure passed on driver init. But how can we do that from
>the
>command line, or even a little script/app once the kernel is up and
>running?
>
>
>The story of our attempt is documented here:
>https://groups.google.com/forum/?hl=en#!topic/richards-tech-user-forum/BjQpWjTmims
>
>Any suggestions on how we can succeed?

Looks like you basically got there with the DT file at the end. Adhoc arrangements
 like this are often done with device tree overlays (which can be added to a
 running device). A quick Google suggests the raspberry pi uses these for standard hats.

Good luck.

Jonathan

>
>Many thanks,
>Simon.
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
