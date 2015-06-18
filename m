Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:53650 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222AbbFRUxz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jun 2015 16:53:55 -0400
Message-ID: <6c946d3c9f99f1d4eb44294311078be5.squirrel@mungewell.org>
In-Reply-To: <A077DCB2-204C-40BC-881D-83CAEF418A6C@kernel.org>
References: <2d05200efc42012bd16be4dde0fad85d.squirrel@mungewell.org>
    <A077DCB2-204C-40BC-881D-83CAEF418A6C@kernel.org>
Date: Thu, 18 Jun 2015 16:53:53 -0400
Subject: Re: ST driver - ad-hoc allocation of trigger interrupt
From: simon@mungewell.org
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


>>The story of our attempt is documented here:
>>https://groups.google.com/forum/?hl=en#!topic/richards-tech-user-forum/BjQpWjTmims
>>
>>Any suggestions on how we can succeed?
>
> Looks like you basically got there with the DT file at the end. Adhoc
> arrangements
>  like this are often done with device tree overlays (which can be added to
> a
>  running device). A quick Google suggests the raspberry pi uses these for
> standard hats.

A little follow-up that you might like; Richard was able to get the IIO
devices configured via Device Tree, even to the point of getting a full
sensor fusion working to give pose and heading.

https://richardstechnotes.wordpress.com/2015/06/17/rteiioimu-driving-a-9-dof-imu-via-industrial-io-iio/

Simon.

