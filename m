Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:53872 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755981Ab0H3Ro4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Aug 2010 13:44:56 -0400
Message-ID: <4C7BEF39.2030507@cam.ac.uk>
Date: Mon, 30 Aug 2010 18:49:45 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	"Song, Barry" <Barry.Song@analog.com>
Subject: Using uinput
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

In a thread to do with the cma3000 accelerometer on lkml Dmitry (input maintainer)
in passing mentioned that an iio to input bridge might exist in userspace
using uinput.

Looks to me like this might kill two birds with one stone for us.

* Would finally provide a route for all those who want their sensor
  drivers in input because they want to use them for games.
* Would provide a fairly good test of the generality of the user space interfaces.

What do people think of this rather than an in kernel bridge?

Given it would trivially have access to all of the info on what the sensor is producing
it actually looks much easier to do than the kernel bridge (which was going to need
a userspace configuration element or a lot of changes to our internal structure).

Jonathan
