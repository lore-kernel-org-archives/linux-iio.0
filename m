Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:65259 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754770Ab2JEJHW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Oct 2012 05:07:22 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so1700033vcb.19
        for <linux-iio@vger.kernel.org>; Fri, 05 Oct 2012 02:07:21 -0700 (PDT)
MIME-Version: 1.0
From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Date: Fri, 5 Oct 2012 14:37:01 +0530
Message-ID: <CAHfPSqCnBw1ed97greGdMz-qexWbB2b5_NrbT6FFUeawvygWWg@mail.gmail.com>
Subject: Querry on IIO/ADC DT based consumer device probe
To: linux-iio@vger.kernel.org, jic23@cam.ac.uk
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello All,

I'm trying to add an ADC driver under IIO/ADC.
Machine is DT based so, passing the ADC device as tree node and
consumer devices (thermistors) as child nodes via DT.

I don't find a frame work to parse the child nodes and probe them like
I2C does using of/of_i2c.c

The DT snippet:
       adc@12D10000 {
                thermistor@3 {
                        compatible = "ntc,ncp15wb473";
                        consumer-name = "ntc,ncp15wb473";
                        consumer-channel = "adc-3";
                        pullup-uV = <1800000>;
                        pullup-ohm = <47000>;
                        pulldown-ohm = <0>;
                        connected-positive;
                };

                thermistor@4 {
                        compatible = "ntc,ncp15wb473";
                        consumer-name = "ntc,ncp15wb473";
                        consumer-channel = "adc-4";
                        pullup-uV = <1800000>;
                        pullup-ohm = <47000>;
                        pulldown-ohm = <0>;
                        connected-positive;
                };
    };

Parsing snippet:
 for_each_child_of_node(node, client_node) {
                char *channel, *label = NULL;

                if (of_property_read_string(client_node,
"consumer-channel", &channel) != 0) {
                        dev_err(&pdev->dev, "Missing consumer-channel
property in the DT.\n");
                        return -EINVAL;
                }

                client_map[i].consumer_channel = channel;
                label = "lable-adc";      //TODO
                client_map[i].adc_channel_label = label;


                if (of_property_read_string(client_node,
"consumer-name", &client_map[i].consumer_dev_name) != 0) {
                        dev_err(&pdev->dev, "Missing consumer-name
property in the DT.\n");
                        return -EINVAL;
                }

                i++;
        }

Can some one suggest a way to get the consumer thermistor driver to
get probed from iio framework via DT.
Kindly, point me towards any existing framework to do the same.

-- 
Shine bright,
(: Nav :)
