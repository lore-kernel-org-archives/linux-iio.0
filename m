Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:58631 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754836Ab1CHNxY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 8 Mar 2011 08:53:24 -0500
Received: from arcturus.eng.cam.ac.uk ([129.169.154.73]:36641)
	by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpsa (PLAIN:jic23) (TLSv1:DHE-RSA-CAMELLIA256-SHA:256)
	id 1PwxLn-0007Jm-E0 (Exim 4.72) for linux-iio@vger.kernel.org
	(return-path <jic23@cam.ac.uk>); Tue, 08 Mar 2011 13:53:23 +0000
Message-ID: <4D763507.2090003@cam.ac.uk>
Date: Tue, 08 Mar 2011 13:54:15 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Build iio as built in rather than module.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Just a heads up.  Right now on a stargate 2 (pxa) I can't boot if
IIO is built in rather than the module I normally use.

Chasing down exactly why now.  Annoyingly this is occurring before
any messages at all come out on the serial console so may take a while
to track down.

Jonathan
