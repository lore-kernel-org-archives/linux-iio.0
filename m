Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34286 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdEOVjl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 May 2017 17:39:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id d127so31935515wmf.1
        for <linux-iio@vger.kernel.org>; Mon, 15 May 2017 14:39:41 -0700 (PDT)
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>,
        srinivas.pandruvada@intel.com
Cc: linux-iio@vger.kernel.org
From: Arek Burdach <arek.burdach@gmail.com>
Subject: Accelometer data not changes
Message-ID: <b9234130-1af6-738f-a174-379d441caedf@gmail.com>
Date: Mon, 15 May 2017 23:39:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I'm trying to investigate bug reported here: 
https://bugzilla.kernel.org/show_bug.cgi?id=195681

I was trying to add similar quirk configuration like for Lenovo Yoga 900 
but it seems that didn't helped. Driver mostly not changing raw data. I 
have a situation that it started to changing data, but I can't reproduce 
it (possibly lsiio execution triggered it)

I found out that there is many similar problems reported on 
iio-sensor-proxy project:
https://github.com/hadess/iio-sensor-proxy/issues?utf8=%E2%9C%93&q=is%3Aissue%20label%3A%22driver%20bug%22%20
, so it look like it is more generic problem.

Can anyone confirm that accelometer works on yoga900/910 in any kernel 
version?

Can somebody help me, how to debug this problem?

Cheers,
Arek
