Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:38891 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132Ab3F1J3V (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jun 2013 05:29:21 -0400
Received: by mail-qa0-f43.google.com with SMTP id d13so434603qak.2
        for <linux-iio@vger.kernel.org>; Fri, 28 Jun 2013 02:29:20 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?Um9iaW4gTcO8bGxlci1CYWR5?= <mueller-bady@linux.com>
Date: Fri, 28 Jun 2013 11:28:40 +0200
Message-ID: <CACRdhnBWk8Vi1fD6+6LknnLoPb8dLBEq3wrMXLofVrqQEEuaFA@mail.gmail.com>
Subject: Start writing new IIO drivers
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I'm currently writing userspace software in python and c for using
(mainly I2C) sensors, e.g. MPL115A2 barometric pressure, on a
raspberry pi.
I now want to port them to the IIO subsystem but I still require some help.
* Is there any good documentation on writing those drivers ? I'm
currently working through examples in the current git kernel version
with assistance of the IIO Introductory slides from Maxime Ripard
"IIO, a new kernel subsystem" but these examples are, in my opinion,
rather difficult.
* As raspbian (raspberry pi specific debian version) comes with a
precompiled kernel 3.6.9, several features of IIO seem to be not yet
included. Compiling a kernel natively on the raspi is no fun (700MHz
ARM), so I don't want to make any mistake with the configs. Which
kernel options of the current stable kernel do I require for IIO/I2C
Sensor communication ?

Thank you very much in advance!

Regards,

Robin
