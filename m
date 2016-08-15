Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41185 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbcHOOhy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 10:37:54 -0400
Received: from [192.168.0.20] (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
	by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 7E1684067C
	for <linux-iio@vger.kernel.org>; Mon, 15 Aug 2016 15:37:50 +0100 (BST)
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Subject: Messed up the fixes-togreg-post-rc1 branch so cherry picking into
 fixes-togreg
Message-ID: <faaec59c-07d8-6618-cd0d-0614e690c3e2@kernel.org>
Date: Mon, 15 Aug 2016 15:37:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

Seems I messed up the base of the fixes-togreg-post-rc1 branch
(based on a random point in togreg rather than the last 
pull request as intended).  I'll drop that branch as
junk having cherry picked into an updated fixes-togreg branch.

Make a bit of a mess of dates, but otherwise should have no
real affect.

This is just in case anyone was basing on that branch which
will shortly disappear.

Jonathan
