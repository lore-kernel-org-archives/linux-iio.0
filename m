Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:45013 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbbCIF3D (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 01:29:03 -0400
Received: by padet14 with SMTP id et14so45943607pad.11
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2015 22:29:02 -0700 (PDT)
Received: from [10.4.1.101] ([122.166.13.141])
        by mx.google.com with ESMTPSA id c8sm16968719pds.5.2015.03.08.22.29.00
        for <linux-iio@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 22:29:01 -0700 (PDT)
Message-ID: <54FD2F9A.2070502@gmail.com>
Date: Mon, 09 Mar 2015 10:58:58 +0530
From: abhijit <abhijitnaik27@gmail.com>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: AD7923 sequencer functionality implementation in Kernel
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

We are using AD7923 driver as reference for one of our customer's ADC IP

The ADC that we are using, has sequencer functionality. In current state 
of AD7923 driver, there is no support for sequencer functionality.

Can you please let me know whether the IIO driver team is coming up with 
design for sequencer functionality of the device.

With Warm Wishes,
       Abhijit Naik
