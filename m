Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:42004 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754739Ab1I2NFV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Sep 2011 09:05:21 -0400
Received: from arcturus.eng.cam.ac.uk ([129.169.154.73]:59355)
	by ppsw-51.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:25)
	with esmtpsa (PLAIN:jic23) (TLSv1:DHE-RSA-CAMELLIA256-SHA:256)
	id 1R9GIi-0003yu-Xz (Exim 4.72) for linux-iio@vger.kernel.org
	(return-path <jic23@cam.ac.uk>); Thu, 29 Sep 2011 14:05:20 +0100
Message-ID: <4E846F08.5070906@cam.ac.uk>
Date: Thu, 29 Sep 2011 14:13:44 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: IIO: angular measurement types.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All

Just looking at add chan spec support for resolvers and
realised that our representations of angular measurements
have become somewhat confused.

Right now we have

IIO_GYRO -> angular velocity (units radians / sec)
IIO_ROT -> vertical rotation position (undocumented)
IIO_ANGL -> rotation angle (currently integrated version of IIO_GYRO, undocumented)

For resolvers we seem to need

Absolute rotation position (IIO_ANGL?)  set units to radians
Angular velocity (IIO_GYRO? - odd naming here) randians / sec

So, proposal is to rename IIO_GYRO - > IIO_ANGL_VEL

Anyone have an thoughts on this?

Jonathan
