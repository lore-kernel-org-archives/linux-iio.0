Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:41264 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934574AbeCHLpF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Mar 2018 06:45:05 -0500
Date: Thu, 08 Mar 2018 11:45:03 +0000
In-Reply-To: <516a7508-c151-52ec-d7dc-dc2df8dba1e3@gmail.com>
References: <9a4d5126-2087-bb75-88ed-f4a902ff7603@gmail.com> <516a7508-c151-52ec-d7dc-dc2df8dba1e3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: GSoC IIO project: David Veenstra
To: David Julian Veenstra <davidjulianveenstra@gmail.com>,
        linux-iio@vger.kernel.org, jic23@kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <83BDCEE3-1946-40D9-94A9-B3B2EAA9E8C4@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 8 March 2018 10:58:23 GMT, David Julian Veenstra <davidjulianveenstra@gmail.com> wrote:
>Dear IIO Community,
>
>For the Coding Task 01, I submitted the following patches:
>https://marc.info/?l=linux-iio&m=152050249930598&w=2
>https://marc.info/?l=linux-iio&m=152050245530583&w=2
>
>Jonathan, in reply to
>https://marc.info/?l=linux-iio&m=151784107521336&w=2, do you have
>a suggestion for a driver to move out of staging?

In would take a look at the CDC or resolver drivers. I particular ABI on those..  let other list
 know which you plan to take on to avoid duplication of effort.

Jonathan
>
>Best regards,
>David Veenstra
>
>On 03/04/2018 11:59 PM, David Julian Veenstra wrote:
>> Dear IIO Comunity,
>>
>> Hello, I'm David Veenstra. Currently, I'm a master of Logic
>> (theoretical computer science) student at the University of
>Amsterdam.
>> Before that I completed a bachelor in Computer Science, also at the
>UvA.
>>
>> My first experience with drivers was during the development of my
>> bachelor thesis. Among others things, I investigated what API was
>> available for writing virtualized drivers for KVM and Xen. Since,
>then
>> I have been working on a hobby OS, and also on virtio PCIe drivers.
>> Furthermore, during a summer internship, I have written a prototype
>> linux nic driver for an FPGA. I have greatly enjoyed this
>experiences,
>> and hence would very much like to join this GSoC project.
>>
>> It is my understanding that the solutions for the tasks should be
>sent
>> in private, so I will send it to the mentor: Daniel Baluta.
>>
>> Best regards,
>> David Veenstra

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
